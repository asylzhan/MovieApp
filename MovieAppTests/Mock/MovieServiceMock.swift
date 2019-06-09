//
//  MovieServiceMock.swift
//  MovieAppTests
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import MovieApp
import ObjectMapper
import RxSwift
import RxCocoa

class MovieServiceMock: MovieServiceProtocol {
  let dict: [String: Any] = ["poster_path": "/4fjlSFUoW6L9FSAE5knxjjUDd6v.jpg",
                             "id": 299534,
                             "genres": [
                              ["id": 12, "name": "приключения"],
                              ["id": 878, "name": "фантастика"],
                              ["id": 28, "name": "боевик"]],
                             "title": "Мстители: Финал",
                             "original_title": "Avengers: Endgame",
                             "revenue": 2722617940,
                             "budget": 356000000,
                             "vote_average": 8.5,
                             "overview": "Мстители и Стражи Галактики вступают в последнюю стадию войны с Таносом, владеющим всемогущей Перчаткой Бесконечности. Грядёт финальная битва между силами героев и Безумного Титана, которая раз и навсегда определит дальнейшую судьбу не только Земли, но и всей вселенной.",
                             "videos": [
                              "results": [
                                ["id": "5c97dc649251416b41f5cdbe",
                                 "iso_639_1": "ru",
                                 "iso_3166_1": "RU",
                                 "key": "gbcVZgO4n4E",
                                 "name": "Мстители: Финал – официальный трейлер (16+)",
                                 "site": "YouTube",
                                 "size": 1080,
                                 "type": "Trailer"],
                                ["id": "5c97dc799251411920f4f267",
                                 "iso_639_1": "ru",
                                 "iso_3166_1": "RU",
                                 "key": "Z5SLkBZTmvM",
                                 "name": "Мстители: Финал – специальный видеоролик",
                                 "site": "YouTube",
                                 "size": 1080,
                                 "type": "Teaser"]
                              ]]]
  
  func fetchPopularMovies(completion: @escaping ([Movie], Error?) -> Void) {
    var movies = [Movie]()
    for _ in 1...5 {
      let movie = Movie(JSON: dict)
      movies.append(movie!)
    }
    
    completion(movies, nil)
  }
  
  func fetchMovieDetails(by id: Int, completion: @escaping (Movie?, Error?) -> Void) {
    let movie = Movie(JSON: dict)
    completion(movie, nil)
  }
  
  func searchMovie(by query: String) -> (Observable<([Movie], Error?)>) {
    
    return Observable.create({ (observer) -> Disposable in
      
      let movie = Movie(JSON: self.dict)
      observer.onNext(([movie!], nil))
      
      return Disposables.create {
      }
    })
  }
  
  func getMockMovie() -> Movie {
   return Movie(JSON: dict)!
  }
}
