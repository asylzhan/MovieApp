//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by asylzhan on 6/7/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit


class AppCoordinator: Coordinator {
  
  let window: UIWindow
  let rootViewController: UINavigationController
  let movieListCoordinator: MovieListCoordinator
  
  init(window: UIWindow) {
    self.window = window
    rootViewController = UINavigationController()
    movieListCoordinator = MovieListCoordinator(navigationController: rootViewController)
  }
  
  func start() {
    window.rootViewController = rootViewController
    movieListCoordinator.start()
    window.makeKeyAndVisible()
  }
}
