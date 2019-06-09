//
//  MovieDetailsCoordinator.swift
//  MovieApp
//
//  Created by asylzhan on 6/8/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit


class MovieDetailsCoordinator: Coordinator {
  private let navigationController: UINavigationController
  private let movie: Movie
  private let movieService: MovieService
  private var movieDetailsViewController: MovieDetailsViewController?


  init(navigationController: UINavigationController, movie: Movie, movieService: MovieService) {
    self.navigationController = navigationController
    self.movie = movie
    self.movieService = movieService
  }
  
  func start() {
    let movieDetailsVC = MovieDetailsViewController()
    let presenter = MovieDetailsPresenter(movie: movie, movieService: movieService)
    movieDetailsVC.presenter = presenter
    presenter.view = movieDetailsVC
    
    navigationController.pushViewController(movieDetailsVC, animated: true)
    self.movieDetailsViewController = movieDetailsVC
  }
}
