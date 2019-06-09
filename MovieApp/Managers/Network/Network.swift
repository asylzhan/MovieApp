//
//  Network.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import Alamofire

enum API {
  private static let key = "e407fcb3c9dab981b62d8bf857f782aa"
  static let baseURL = "https://api.themoviedb.org"
  private static let v3 = "/3/"
  static let mainApiURL = baseURL + v3
  static let imageURL = "https://image.tmdb.org/t/p/w500"
  
  enum QueryParam {
    static let key = "?api_key=\(API.key)"
    static let ruLanguage = "&language=ru"
  }
}

typealias ResponseHandler = ([String: Any]?, Error?) -> Void

class Network {
  
  private static func customValidation(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Request.ValidationResult {
    do {
      guard let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {
        debugPrint("expected dictionary response")
        let error = NSError(domain: "Expected dictionary response", code: 0, userInfo: nil)
        return .failure(error)
      }
      if let errorsArray = jsonResponse["errors"] as? [String] {
        let errorMsg = errorsArray.joined(separator: ". ")
        let error = NSError(domain: errorMsg, code: 0, userInfo: nil)
        return .failure(error)
      }
      if let errorsDict = jsonResponse["errors"] as? [String: Any] {
        let errorsArray = errorsDict.values.first as! [String]
        let errorMsg = errorsArray.joined(separator: ". ")
        let error = NSError(domain: errorMsg, code: 0, userInfo: nil)
        return .failure(error)
      }
      if let errorString = jsonResponse["errors"] as? String {
        let error = NSError(domain: errorString, code: 0, userInfo: nil)
        return .failure(error)
      }
    } catch let error {
      return .failure(error)
    }
    
    return .success
  }
  
  static func customRequestWith(url: String, method: HTTPMethod, params: Parameters, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping ResponseHandler) -> DataRequest {
    
    var customHeader: HTTPHeaders?
    
    if headers == nil {
      customHeader = [
        "Content-Type": "application/json; charset=utf-8"
      ]
    } else {
      customHeader = headers
    }
    
    debugPrint("Request header is - \(String(describing: customHeader))")
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    
    let manager = Alamofire.SessionManager.default
    manager.session.configuration.timeoutIntervalForRequest = 30
    
    var formattedURL = url
    if !formattedURL.contains("http") {
      formattedURL = API.baseURL + formattedURL
    }
    
    return manager.request(formattedURL, method: method, parameters: params, encoding: encoding, headers: customHeader)
      .validate { (request, response, data) -> Request.ValidationResult in
        debugPrint("Request is - \(String(describing: request))")
        return customValidation(request: request, response: response, data: data)
      }
      .responseJSON { (response) in
        switch response.result {
        case .success(let value):
          let responseDict = value as! [String: Any]
          completion(responseDict, nil)
        case .failure(let error):
          if response.response?.statusCode == 200 || response.response?.statusCode == 204 {
            debugPrint(error)
            completion(nil, nil)
            return
          } else {
            debugPrint("Error - ", error, response.request?.url ?? "", response.response?.statusCode ?? -1)
            
            completion(nil, error)
          }
        }
    }
  }

}
