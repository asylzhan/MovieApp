//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
  
  // MARK: Properties
  fileprivate lazy var scrollView: UIScrollView = {
    let scView = UIScrollView()
    scView.backgroundColor = .clear
    scView.showsVerticalScrollIndicator = false
    scView.translatesAutoresizingMaskIntoConstraints = false
    return scView
  }()
  
  fileprivate lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate lazy var videoView: VideoView = {
    let view = VideoView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate lazy var videoContentView: VideoContentView = {
    let view = VideoContentView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate lazy var originalTitleLabel: UILabel = {
    let label = UILabel()
    label.textColor =  Colors.darkSlate
    label.textAlignment = .left
    label.font = UIFont.avenirMedium(size: 18)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var ratingView: RatingView = {
    let view = RatingView()
    view.font = UIFont.avenirMedium(size: 16)
    view.titleColor = Colors.darkSlate
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var presenter: MovieDetailsPresentation?

  
  // MARK: View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    presenter?.fetchMovieDetails()
    
    setupBackBarButtonItem { (imgView) in
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgView.image, style: .plain, target: self, action: #selector(didTapBack))
    }
  }
  
  // MARK: Setup
  private func setupViews() {
    view.backgroundColor = .white
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubviews(videoView, originalTitleLabel, videoContentView, ratingView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    activate([scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
              scrollView.topAnchor.constraint(equalTo: view.topAnchor),
              scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
              
              contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
              contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
              contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
              contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
              
              videoView.topAnchor.constraint(equalTo: contentView.topAnchor),
              videoView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
              videoView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
              videoView.heightAnchor.constraint(equalToConstant: 240),
              
              originalTitleLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 12),
              originalTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
              originalTitleLabel.rightAnchor.constraint(equalTo: ratingView.leftAnchor, constant: -8.0),
              
              ratingView.centerYAnchor.constraint(equalTo: originalTitleLabel.centerYAnchor, constant: 0),
              ratingView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
              ratingView.heightAnchor.constraint(equalToConstant: 14.5),
              
              videoContentView.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 8),
              videoContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
              videoContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
              videoContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
              ])
        
    ratingView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
  }
  
  // MARK: Action
  @objc private func didTapBack() {
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: Deinit
  deinit {
    debugPrint("Deinit --\(self)--")

  }
}

// MARK: - MovieDetailsView
extension MovieDetailsViewController: MovieDetailsView {
  func updateMovieTrailer(url: URL?) {
    videoView.loadVideo(url: url)
  }
  
  func updateDetails(_ movie: Movie) {
    navigationItem.title = movie.title
    videoContentView.movie = movie
    originalTitleLabel.text = movie.originalTitle
    ratingView.rating = movie.averageVote
  }
}
