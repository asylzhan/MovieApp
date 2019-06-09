//
//  VideoView.swift
//  MovieApp
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit


class VideoView: UIView {
  
  // MARK: Properties
  fileprivate lazy var webView: UIWebView = {
    let webView = UIWebView()
    webView.scrollView.isScrollEnabled = false
    webView.isOpaque = false
    webView.delegate = self
    webView.backgroundColor = UIColor(red: 112.0/255.0, green: 130.0/255.0, blue: 143.0/255.0, alpha: 1.0)
    webView.translatesAutoresizingMaskIntoConstraints = false
    return webView
  }()
  
  fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
    view.hidesWhenStopped = true
    return view
  }()
  
  private lazy var posterImageView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "clapperboard")
    imgView.contentMode = .scaleAspectFit
    imgView.clipsToBounds = true
    imgView.backgroundColor = Colors.ghostPale
    imgView.isHidden = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  // MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupViews()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    activityIndicator.center = webView.center
  }
  
  // MARK: Setup
  private func setupViews() {
    addSubviews(webView, posterImageView)
    webView.addSubview(activityIndicator)

    activityIndicator.startAnimating()

    setupConstraints()
  }
  
  private func setupConstraints() {
    activate([webView.topAnchor.constraint(equalTo: topAnchor),
              webView.rightAnchor.constraint(equalTo: rightAnchor),
              webView.leftAnchor.constraint(equalTo: leftAnchor),
              webView.bottomAnchor.constraint(equalTo: bottomAnchor),
              
              posterImageView.topAnchor.constraint(equalTo: topAnchor),
              posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
              posterImageView.leftAnchor.constraint(equalTo: leftAnchor),
              posterImageView.rightAnchor.constraint(equalTo: rightAnchor)])
  }
  
  // MARK: Helper methods
  func loadVideo(url videoURL: URL?) {
    if videoURL == nil || !ReachabilityManager.shared.isReachable() {
      activityIndicator.stopAnimating()
      showDefaultImageView(true)
      return
    }
    
    webView.loadRequest(URLRequest(url: videoURL!))
  }
  
  private func showDefaultImageView(_ show: Bool) {
    posterImageView.isHidden = !show
    webView.isHidden = show
  }
}

// MARK: - UIWebViewDelegate
extension VideoView: UIWebViewDelegate {
  func webViewDidFinishLoad(_ webView: UIWebView) {
    activityIndicator.stopAnimating()
  }
}

