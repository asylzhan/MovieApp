//
//  ModelMapperHelper.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import ObjectMapper


// MARK: - Image URL String
let imageUrlTransform = TransformOf(fromJSON: { (value: String?) -> String? in
  if let value = value, !value.isEmpty {
    return API.baseURL + value
  }
  return nil
}) { (value: String?) -> String? in
  return nil
}

// MARK: - Int
let intTransform = TransformOf(fromJSON: { (value: Any?) -> Int? in
  if let value = value as? String {
    if let intValue = Int(value) {
      return intValue
    } else {
      return nil
    }
  }
  else if let value = value as? Int {
    return value
  }
  return nil
}) { (value: Int?) -> String? in
  if let value = value {
    return String(describing: value)
  }
  return nil
}

// MARK: - Date
let dateTransform = TransformOf(fromJSON: { (value: Any?) -> Date? in
  if let value = value as? String {
    var date: Date?
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    date = dateFormatter.date(from: value)
    if date == nil {
      dateFormatter.dateFormat = "yyyy-MM-dd"
      date = dateFormatter.date(from: value)
    }
    return date
  } else if let value = value as? Double {
    let date = Date(timeIntervalSince1970: value / 1000.0)
    return date
  }
  return nil
}) { (value: Date?) -> String? in
  return nil
}


// MARK: - Double
let doubleTransform = TransformOf(fromJSON: { (value: Any?) -> Double in
  if let value = value as? String {
    if let doubleValue = Double(value) {
      return doubleValue
    }
    return 0.0
  } else if let value = value as? Double {
    return value
  }
  return 0
}) { (value: Double?) -> String? in
  if let value = value {
    return String(describing: value)
  }
  return nil
}
