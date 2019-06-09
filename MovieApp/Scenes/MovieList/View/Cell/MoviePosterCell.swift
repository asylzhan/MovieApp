//
//  MoviePosterCell.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit
import SDWebImage

class MoviePosterCell: BaseCollectionCell {
  
  // MARK: Properties
  private lazy var posterImageView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "clapperboard")
    imgView.contentMode = .scaleAspectFill
    imgView.clipsToBounds = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.avenirDemiBold(size: 14)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = Colors.lightGrey
    return label
  }()
  
  private lazy var ratingView: RatingView = {
    let label = RatingView()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private var gradientLayer: CAGradientLayer!
  
  var movie: Movie? {
    didSet {
      guard let movie = movie else { return }
      configure(movie)
    }
  }
  
  var imageName: String? {
    didSet {
      guard let imageName = imageName else { return }
      posterImageView.image = UIImage(named: imageName)
    }
  }
  
  // MARK: Setup
  override func setupViews() {
    contentView.addSubviews(posterImageView, titleLabel, ratingView)
    
    setupConstraints()
    createGradientForLayer()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    posterImageView.image = UIImage(named: "clapperboard")
    titleLabel.text = nil
  }
  
  private func setupConstraints() {
    activate([posterImageView.topAnchor.constraint(equalTo: topAnchor),
              posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
              posterImageView.leftAnchor.constraint(equalTo: leftAnchor),
              posterImageView.rightAnchor.constraint(equalTo: rightAnchor),
              
              titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
              titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
              titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
              
              ratingView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
              ratingView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
              ratingView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
              ratingView.heightAnchor.constraint(equalToConstant: 14.5),])
  }
  
  private func createGradientForLayer() {
    gradientLayer = CAGradientLayer()
    gradientLayer.colors = [UIColor.black.withAlphaComponent(0.6).cgColor, UIColor.white.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
    gradientLayer.locations = [0.0, 0.2, 0.8]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    posterImageView.layer.addSublayer(gradientLayer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = self.bounds
  }
  
  private func configure(_ movie: Movie) {
    titleLabel.text = movie.title
    ratingView.rating = movie.averageVote
    
    guard let posterImageURL = movie.posterImageURL else { return }
    let posterURL = URL(string: API.imageURL + posterImageURL)
    posterImageView.sd_setImage(with: posterURL)
  }
}
