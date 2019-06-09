//
//  UIFont+Extensions.swift
//  MovieApp
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

extension UIFont {
  static func avenirMedium(size: CGFloat) -> UIFont {
    return UIFont(name: "AvenirNext-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
  }
  
  static func avenirRegular(size: CGFloat) -> UIFont {
    return UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
  }
  
  static func avenirDemiBold(size: CGFloat) -> UIFont  {
    return UIFont(name: "AvenirNext-DemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
  }
}
