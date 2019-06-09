//
//  MovieDetailsPresenter.swift
//  MovieApp
//
//  Created by asylzhan on 6/7/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation

// MARK: - MovieDetailsPresentation protocol
public protocol MovieDetailsPresentation: class {
  func fetchMovieDetails()
}

// MARK: - MovieDetailsView protocol
public protocol MovieDetailsView: IndicatableView {
  func updateMovieTrailer(url: URL?)
  func updateDetails(_ movie: Movie)
}

// MARK: - MovieDetailsPresenter protocol
public class MovieDetailsPresenter: CommonPresenter {
  weak var view: MovieDetailsView?
  fileprivate var movie: Movie?
  fileprivate var movieService: MovieServiceProtocol?

  init(movie: Movie, movieService: MovieServiceProtocol) {
    self.movie = movie
    self.movieService = movieService
  }
}

extension MovieDetailsPresenter: MovieDetailsPresentation {
  public func fetchMovieDetails() {
    guard let id = movie?.id else {
      view?.showError(with: Constants.Misc.genericError)
      return
    }
    
    view?.showActivityIndicator()
    
    movieService?.fetchMovieDetails(by: id) { (movie, error) in
      guard error == nil else {
        self.view?.showError(with: error?.localizedDescription ?? Constants.Misc.genericError)
        return
      }

      self.view?.hideActivityIndicator()
      
      guard let movie = movie else {
        self.view?.updateDetails(self.movie!)
        self.view?.updateMovieTrailer(url: nil)
        return
      }
      
      self.view?.updateDetails(movie)
      
      if let trailerKey = movie.videos?.getYoutubeTrailer()?.key {
        let url = URL(string: "https://www.youtube.com/embed/\(trailerKey)")
        self.view?.updateMovieTrailer(url: url)
      } else {
        self.view?.updateMovieTrailer(url: nil)
      }
    }
    
  }
}
