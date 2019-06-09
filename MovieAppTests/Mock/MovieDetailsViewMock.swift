//
//  MovieDetailsViewMock.swift
//  MovieAppTests
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import MovieApp
import ObjectMapper

class MovieDetailsViewMock: MovieDetailsView {
  func showActivityIndicator() {}
  func showActivityIndicator(with delay: Double) {}
  func showError(with message: String) {}
  func show(_ message: String) {}
  func hideActivityIndicator() {}
  func hideActivityIndicatorWith(completion: @escaping () -> Void) {}
  
  var updateDetailsCalled = false
  var updateMovieTrailerCalled = false
  var title: String?
  var budget: Int?
  
  func updateDetails(_ movie: Movie) {
    updateDetailsCalled = true
    title = movie.title
    budget = movie.budget
  }
  
  func updateMovieTrailer(url: URL?) {
    updateMovieTrailerCalled = true
  }
  
}
