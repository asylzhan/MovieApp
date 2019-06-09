//
//  Constants.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

enum Colors {
  static let mainGrayColor = UIColor(red: 160.0/255.0, green: 160.0/255.0, blue: 160.0/255.0, alpha: 1.0)
  static let ghostPale = UIColor(red: 246.0/255.0, green: 248.0/255.0, blue: 253.0/255.0, alpha: 1.0)
  static let lightGrey = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1.0)
  static let navigationTextColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 99.0/255.0, alpha: 1.0)
  static let darkSlate = UIColor(red: 33.0/255.0, green: 38.0/255.0, blue: 44.0/255.0, alpha: 1.0)
}

enum Constants {
  
  // Misc
  enum Misc {
    static let nothingFoundError = "Ничего не найдено"
    static let networkError = "Не удаётся установить соединение с сервером. Попробуйте заново"
    static let genericError = "Ошибка!"
  }
  
  enum Cache {
    static let movies = "MoviesCache"
  }
}
