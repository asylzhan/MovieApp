//
//  MovieAPI.swift
//  MovieApp
//
//  Created by asylzhan on 6/7/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import Alamofire

class MovieAPI {
  
  static func getPopularMovies(completion: @escaping ResponseHandler) {
    let url = API.mainApiURL + "movie/popular\(API.QueryParam.key)\(API.QueryParam.ruLanguage)"
    
    _ = Network.customRequestWith(url: url, method: .get, params: [:], completion: completion)
  }
  
  static func getSearchMovie(query: String, completion: @escaping ResponseHandler) -> DataRequest {
    let url = API.mainApiURL + "search/movie\(API.QueryParam.key)\(API.QueryParam.ruLanguage)"
    let params = ["query": query]
    
    return Network.customRequestWith(url: url, method: .get, params: params, encoding: URLEncoding.default, headers: nil, completion: completion)
  }
  
  static func getMovieTrailerURL(by id: Int, completion: @escaping ResponseHandler) {
    let url = API.mainApiURL + "movie/\(id)/videos\(API.QueryParam.key)\(API.QueryParam.ruLanguage)"
    
    _ = Network.customRequestWith(url: url, method: .get, params: [:], completion: completion)
  }
  
  static func getMovieDetails(by id: Int, completion: @escaping ResponseHandler) {
    let url = API.mainApiURL + "movie/\(id)\(API.QueryParam.key)\(API.QueryParam.ruLanguage)&append_to_response=videos"
    
    _ = Network.customRequestWith(url: url, method: .get, params: [:], completion: completion)
  }
}


