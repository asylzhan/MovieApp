//
//  FloatingPoint+Extensions.swift
//  MovieApp
//
//  Created by asylzhan on 6/7/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation

extension Double {
  /// By default rounds by 2 digit after floating point
  func round(_ places: Int = 2) -> Double {
    let divisor = pow(10.0, Double(places))
    return Darwin.round(self * divisor) / divisor
  }
}
