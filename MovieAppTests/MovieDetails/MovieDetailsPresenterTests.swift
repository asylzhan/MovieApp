//
//  MovieDetailsPresenterTests.swift
//  MovieAppTests
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieDetailsPresenterTests: XCTestCase {
  
  var serviceMock: MovieServiceMock!
  var viewMock: MovieDetailsViewMock!
  var presenterTest: MovieDetailsPresenter!
  
  override func setUp() {
    super.setUp()
    
    serviceMock = MovieServiceMock()
    viewMock = MovieDetailsViewMock()
    presenterTest = MovieDetailsPresenter(movie: serviceMock.getMockMovie(), movieService: serviceMock)
    presenterTest.view = viewMock
  }
  
  override func tearDown() {
    super.tearDown()
    
    serviceMock = nil
    viewMock = nil
    presenterTest = nil
  }
  
  func testShouldUpdateDetailsView() {
    presenterTest.fetchMovieDetails()
    
    XCTAssertTrue(viewMock.updateDetailsCalled, "view should be updated with details")
  }
  
  func testShouldUpdateMovieTrailer() {
    presenterTest.fetchMovieDetails()
    XCTAssertTrue(viewMock.updateMovieTrailerCalled, "view should be updated with movie trailer")
  }
  
  func testMovieTitle() {
    presenterTest.fetchMovieDetails()
    
    XCTAssertEqual(viewMock.title, "Мстители: Финал")
  }
  
  func testMovieBudget() {
    presenterTest.fetchMovieDetails()
    
    XCTAssertEqual(viewMock.budget, 356000000)
  }
}
