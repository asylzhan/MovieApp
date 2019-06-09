//
//  MovieListViewMock.swift
//  MovieAppTests
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import MovieApp

class MovieListViewMock: MovieListView {
  func showActivityIndicator() {}
  func showActivityIndicator(with delay: Double) {}
  func showError(with message: String) {}
  func show(_ message: String) {}
  func hideActivityIndicator() {}
  func hideActivityIndicatorWith(completion: @escaping () -> Void) {}
  
  
  var updateViewCalled = false
  
  func updateView(with movies: [Movie]) {
    updateViewCalled = true
  }
}
