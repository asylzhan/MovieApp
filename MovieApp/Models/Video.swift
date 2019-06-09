//
//  Video.swift
//  MovieApp
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Video: Mappable {
  var id: String?
  var name: String?
  var type: String?
  var site: String?
  var key: String?
  
  public init?(map: Map) {}
  
  public mutating func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    type <- map["type"]
    site <- map["site"]
    key <- map["key"]
  }
}


extension Collection where Iterator.Element == Video {
  func getYoutubeTrailer() -> Video? {
    var video: Video?
    
    guard !self.isEmpty else { return nil }
    
    for currentVideo in self {
      if currentVideo.type == "Trailer" && currentVideo.site == "YouTube" {
        video = currentVideo
        break
      }
    }
    
    return video
  }
}
