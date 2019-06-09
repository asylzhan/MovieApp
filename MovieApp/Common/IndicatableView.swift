//
//  IndicatableView.swift
//  MovieApp
//
//  Created by asylzhan on 6/7/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit
import PKHUD

public protocol IndicatableView: class {
  func showActivityIndicator()
  func showActivityIndicator(with delay: Double)
  func showError(with message: String)
  func show(_ message: String)
  func hideActivityIndicator()
  func hideActivityIndicatorWith(completion: @escaping() -> Void)
}

extension IndicatableView where Self: UIViewController {
  
  func showActivityIndicator() {
    var onView: UIView!
    if self.navigationController != nil {
      onView = self.navigationController!.view
    } else {
      onView = self.view
    }
    HUD.show(.progress, onView: onView)
  }
  
  func showActivityIndicator(with delay: Double) {
    var onView: UIView!
    if self.navigationController != nil {
      onView = self.navigationController!.view
    } else {
      onView = self.view
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      HUD.show(.progress, onView: onView)
    }
  }
  
  func hideActivityIndicator() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      HUD.hide()
    }
  }
  
  func hideActivityIndicatorWith(completion: @escaping() -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      HUD.hide()
      completion()
    }
  }
  
  func showError(with message: String) {
    var onView: UIView!
    if self.navigationController != nil {
      onView = self.navigationController!.view
    } else {
      onView = self.view
    }
    HUD.show(.labeledError(title: Constants.Misc.genericError, subtitle: message), onView: onView)
    HUD.hide(afterDelay: 1.5)
  }
  
  func show(_ message: String) {
    var onView: UIView!
    if self.navigationController != nil {
      onView = self.navigationController!.view
    } else {
      onView = self.view
    }
    HUD.show(.label(message), onView: onView)
    HUD.hide(afterDelay: 1.5)
  }
}

