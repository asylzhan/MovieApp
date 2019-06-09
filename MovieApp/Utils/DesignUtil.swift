//
//  DesignUtil.swift
//  MovieApp
//
//  Created by asylzhan on 6/7/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

class DesignUtil {
  static func configureToAppAppearance() {
    UINavigationBar.appearance().tintColor = Colors.navigationTextColor
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.navigationTextColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: .medium)]
    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.navigationTextColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)], for: [.normal, .highlighted, .selected, .disabled])
  }
}


class FormatUtil {
  static func getFormattedAmount(amount: Int) -> String? {
    let number = amount as NSNumber
    
    let numberFormatter = NumberFormatter()
    numberFormatter.groupingSize = 3
    numberFormatter.groupingSeparator = " "
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.numberStyle = .decimal

    return numberFormatter.string(from: number)
  }
  
  static func getDefaultAttributedText(initial title: String, description: String) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: "\(title) \(description)")
    attributedString.addAttributes([NSAttributedStringKey.font: UIFont.avenirDemiBold(size: 17), NSAttributedStringKey.foregroundColor: Colors.darkSlate],
                                   range: NSMakeRange(0, title.count))
    attributedString.addAttributes([NSAttributedStringKey.font: UIFont.avenirRegular(size: 16)],
                                   range: NSMakeRange(title.count, attributedString.length - title.count))
    
    return attributedString
  }
}
