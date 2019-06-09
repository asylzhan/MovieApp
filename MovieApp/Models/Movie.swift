//
//  Movie.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Movie: Mappable {
  
  public var id: Int?
  public var posterImageURL: String?
  public var title: String?
  public var originalTitle: String?
  public var overview: String?
  public var genres: [Genre]?
  public var averageVote: Double?
  public var releaseDate: Date?
  public var budget: Int?
  public var revenue: Int?
  public var videos: [Video]?
  
  public init?(map: Map) {}

  public mutating func mapping(map: Map) {
    id <- (map["id"], intTransform)
    posterImageURL <- map["poster_path"]
    title <- map["title"]
    originalTitle <- map["original_title"]
    overview <- map["overview"]
    genres <- map["genres"]
    averageVote <- (map["vote_average"], doubleTransform)
    releaseDate <- (map["release_date"], dateTransform)
    budget <- (map["budget"], intTransform)
    revenue <- (map["revenue"], intTransform)
    videos <- map["videos.results"]
  }
}


