//
//  UIView+Extensions.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach(addSubview)
  }
  
  func origin (_ point : CGPoint){
    frame.origin.x = point.x
    frame.origin.y = point.y
  }
}


extension UIDevice {
  var isPortrait: Bool  {
    guard self.orientation == .portrait || self.orientation == .portraitUpsideDown || self.orientation == .faceUp || self.orientation == .faceDown  else {
      return false
    }
    
    return true
  }
}
