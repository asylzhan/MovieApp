//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by asylzhan on 6/7/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

// MARK: - MoviePresentation protocol
public protocol MoviePresentation: class {
  func fetchMovies()
  func searchMovie(by query: String) -> Observable<[Movie]>
}

// MARK: - MovieListView protocol
public protocol MovieListView: IndicatableView {
  func updateView(with movies: [Movie])
}

// MARK: - MovieListPresenter
public class MovieListPresenter: CommonPresenter {
  weak var view: MovieListView?
  fileprivate var movieService: MovieServiceProtocol?
  
  init(movieService: MovieServiceProtocol) {
    self.movieService = movieService
  }
}

extension MovieListPresenter: MoviePresentation {
  public func fetchMovies() {
    self.view?.showActivityIndicator()
    
    movieService?.fetchPopularMovies { (movies, error) in
      guard error == nil else {
        self.view?.showError(with: error?.localizedDescription ?? Constants.Misc.genericError)
        return
      }
      
      self.view?.hideActivityIndicator()
      self.view?.updateView(with: movies)
    }
  }
  
  public func searchMovie(by query: String) -> Observable<[Movie]> {
    return movieService!.searchMovie(by: query)
      .map { (movies, error) in
        guard error == nil else {
          self.view?.showError(with: error?.localizedDescription ?? Constants.Misc.genericError)
          return [Movie]()
        }
        
        return movies
      }
  }
}
