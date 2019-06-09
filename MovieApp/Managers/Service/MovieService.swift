//
//  MovieService.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import RxCocoa
import CoreData
import Alamofire

public protocol MovieServiceProtocol {
  func fetchPopularMovies(completion: @escaping([Movie], Error?) -> Void)
  func searchMovie(by query: String) -> (Observable<([Movie], Error?)>)
  func fetchMovieDetails(by id: Int, completion: @escaping(Movie?, Error?) -> Void)
}

class MovieService: MovieServiceProtocol {
  fileprivate lazy var moviesCache = Cache<Movie>()
  
  /// Get popular movies
  func fetchPopularMovies(completion: @escaping ([Movie], Error?) -> Void) {
    guard ReachabilityManager.shared.isReachable() else {
      guard let movies = self.moviesCache.loadObjects(Constants.Cache.movies) else {
        completion([], nil)
        return
      }
      
      completion(movies, nil)
      return
    }
    
    MovieAPI.getPopularMovies { (response, error) in
      guard error == nil else {
        completion([], error)
        return
      }
      
      guard let results = response?["results"] as? [[String: Any]] else {
        let err = NSError(domain: "Произошла ошибка", code: 0, userInfo: nil)
        completion([], err)
        return
      }
      
      let movies = Mapper<Movie>().mapArray(JSONArray: results)
      completion(movies, nil)
      
      self.moviesCache.save(movies.toJSON(), for: Constants.Cache.movies)
    }
  }
  
  /// Search movie by query
  func searchMovie(by query: String) -> (Observable<([Movie], Error?)>) {
    return Observable.create({ (observer) -> Disposable in
      guard ReachabilityManager.shared.isReachable() else {
        guard let movies = self.moviesCache.loadObjects(query) else {
          observer.onNext(([], nil))
          return Disposables.create()
        }
        
        observer.onNext((movies, nil))
        
        return Disposables.create()
      }
      
      let req = MovieAPI.getSearchMovie(query: query) { response, error in
        guard error == nil else {
          observer.onNext(([], error))
          return
        }
        
        guard let results = response?["results"] as? [[String: Any]] else {
          let err = NSError(domain: "Произошла ошибка", code: 0, userInfo: nil)
          observer.onNext(([], err))
          return
        }
        
        let movies = Mapper<Movie>().mapArray(JSONArray: results)
        observer.onNext((movies, nil))
        self.moviesCache.save(movies.toJSON(), for: query)
      }
      
      return Disposables.create {
        req.cancel()
      }
    })
  }
  
  /// Fetch movie details by its id
  func fetchMovieDetails(by id: Int, completion: @escaping (Movie?, Error?) -> Void) {
    guard ReachabilityManager.shared.isReachable() else {
      guard let movie = moviesCache.loadObject(String(describing: id)) else {
        completion(nil, nil)
        return
      }
      
      completion(movie, nil)
      return
    }
    
    MovieAPI.getMovieDetails(by: id) { (response, error) in
      guard error == nil else {
        completion(nil, error)
        return
      }

      let movie = Movie(JSON: response!)
      completion(movie, nil)
      self.moviesCache.save(movie!.toJSON(), for: String(describing: id))
    }
  }
}
