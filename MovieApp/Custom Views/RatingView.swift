//
//  RatingView.swift
//  MovieApp
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

class RatingView: UIView {
  
  // MARK: Properties
  private lazy var ratingLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.avenirDemiBold(size: 12)
    label.textAlignment = .center
    label.textColor = Colors.lightGrey
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var ratingStarImageView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "rating_star")?.withRenderingMode(.alwaysTemplate)
    imgView.tintColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    imgView.contentMode = .scaleAspectFit
    imgView.clipsToBounds = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  var rating: Double? {
    didSet {
      if let rating = rating, rating != 0 {
        ratingLabel.text = "\(rating.round())"
        ratingStarImageView.isHidden = false
      } else {
        ratingLabel.text = nil
        ratingStarImageView.isHidden = true
      }
    }
  }
  
  var font: UIFont! {
    didSet {
      ratingLabel.font = font
    }
  }
  
  var titleColor: UIColor! {
    didSet {
      ratingLabel.textColor = titleColor
    }
  }
  
  // MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupViews()
  }
  
  // MARK: Setup
  private func setupViews() {
    addSubviews(ratingLabel, ratingStarImageView)    
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    activate([ratingLabel.rightAnchor.constraint(equalTo: rightAnchor),
              ratingLabel.topAnchor.constraint(equalTo: topAnchor),
              ratingLabel.heightAnchor.constraint(equalToConstant: 14.5),
              
              ratingStarImageView.rightAnchor.constraint(equalTo: ratingLabel.leftAnchor, constant: -4),
              ratingStarImageView.topAnchor.constraint(equalTo: topAnchor),
              ratingStarImageView.heightAnchor.constraint(equalToConstant: 14),
              ratingStarImageView.widthAnchor.constraint(equalToConstant: 14)])
  }
}

