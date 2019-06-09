//
//  Genre.swift
//  MovieApp
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Genre: Mappable {
  var id: Int?
  var name: String?
  
  public init?(map: Map) {}
  
  public mutating func mapping(map: Map) {
    id <- (map["id"], intTransform)
    name <- map["name"]
  }
}


extension Collection where Iterator.Element == Genre {
  func getGenresText() -> String {
    guard !self.isEmpty else { return "-" }
    
    let names = self.compactMap { $0.name }
    return names.joined(separator: ", ")
  }
}
