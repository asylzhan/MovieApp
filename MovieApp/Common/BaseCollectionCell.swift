//
//  BaseCollectionCell.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {}
  
}
