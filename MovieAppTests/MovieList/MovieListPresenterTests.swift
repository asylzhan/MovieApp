//
//  MovieListPresenterTests.swift
//  MovieAppTests
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieListPresenterTests: XCTestCase {
  
  var movieServiceMock: MovieServiceMock!
  var movieListViewMock: MovieListViewMock!
  var presenterTest: MovieListPresenter!
  
  override func setUp() {
    super.setUp()
    
    movieServiceMock = MovieServiceMock()
    movieListViewMock = MovieListViewMock()
    presenterTest = MovieListPresenter(movieService: movieServiceMock)
    presenterTest.view = movieListViewMock
  }
  
  override func tearDown() {
    super.tearDown()
    
    movieServiceMock = nil
    movieListViewMock = nil
    presenterTest = nil
  }
  
  func testShouldUpdateView() {
    presenterTest.fetchMovies()
    
    XCTAssertTrue(movieListViewMock.updateViewCalled, "view should be updated")
  }
  
  func testMoviesCount() {
    let expectation = self.expectation(description: "PopularMovies")
    var movieList: [Movie]?
    
    movieServiceMock.fetchPopularMovies { (movies, error) in
      movieList = movies
      
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertEqual(movieList!.count, 5)

  }
  
  func testMoviesForNil() {
    let expectation = self.expectation(description: "PopularMovies")
    var movieList: [Movie]?
    
    movieServiceMock.fetchPopularMovies { (movies, error) in
      movieList = movies
      
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotNil(movieList, "Movies fetch successfully, so movieList should not be nil")
  }
}
