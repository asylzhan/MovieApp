//
//  Cache.swift
//  MovieApp
//
//  Created by asylzhan on 6/10/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import ObjectMapper

final class Cache<T: Mappable> {
  var storage = FileStorage()

  func loadObject(_ key: String) -> T? {
    let data = storage[key]

    guard let curentData = data else { return nil }

    let json = try? JSONSerialization.jsonObject(with: curentData, options: JSONSerialization.ReadingOptions())
    guard let content = json as? [String: Any] else { return nil }

    return T(JSON: content)
  }

  func loadObjects(_ key: String) -> [T]? {
    let data = storage[key]

    guard let curentData = data else { return nil }

    let json = try? JSONSerialization.jsonObject(with: curentData, options: JSONSerialization.ReadingOptions())
    guard let content = json as? [[String: Any]] else { return nil }

    return Mapper<T>().mapArray(JSONArray: content)
  }

  func save(_ object: Any, for key: String) {
    let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
    storage[key] = data
  }

  func remove(_ key: String) {
    storage.remove(at: key)
  }
}
