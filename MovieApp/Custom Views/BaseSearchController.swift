//
//  BaseSearchController.swift
//  MovieApp
//
//  Created by asylzhan on 6/7/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
  
  override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
    super.setShowsCancelButton(false, animated: animated)
  }
}

class CustomSearchController: UISearchController, UISearchBarDelegate {
  lazy var _searchBar: CustomSearchBar = {
    [unowned self] in
    let bar = CustomSearchBar(frame: CGRect.zero)
    bar.delegate = self
    return bar
    }()
  
  override var searchBar: UISearchBar {
    get {
      return _searchBar
    }
  }
}
