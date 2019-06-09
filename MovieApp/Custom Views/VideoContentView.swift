//
//  VideoContentView.swift
//  MovieApp
//
//  Created by asylzhan on 6/9/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit


class VideoContentView: UIView {
  
  // MARK: Properties
  fileprivate lazy var contentView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.alignment = .leading
    stackView.spacing = 8.0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  fileprivate lazy var genresLabel: UILabel = {
    let label = UILabel()
    label.textColor = Colors.darkSlate
    label.textAlignment = .left
    label.font = UIFont.avenirMedium(size: 21)
    label.numberOfLines = 0
    label.text = "-"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var overviewLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.avenirRegular(size: 18)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.text = "-"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var releaseDateLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "-"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var budgetLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.text = "-"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var revenueLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.text = "-"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy"
    return formatter
  }()
  
  var movie: Movie? {
    didSet {
      guard let movie = movie else { return }
      configure(movie)
    }
  }
  
  // MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: Setup
  private func setupViews() {
    addSubview(contentView)
    contentView.addArrangedSubview(overviewLabel)
    contentView.addArrangedSubview(genresLabel)
    contentView.addArrangedSubview(releaseDateLabel)
    contentView.addArrangedSubview(budgetLabel)
    contentView.addArrangedSubview(revenueLabel)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    activate([contentView.topAnchor.constraint(equalTo: topAnchor),
              contentView.rightAnchor.constraint(equalTo: rightAnchor),
              contentView.leftAnchor.constraint(equalTo: leftAnchor),
              contentView.bottomAnchor.constraint(equalTo: bottomAnchor)])
  }
  
  private func configure(_ movie: Movie) {
    overviewLabel.attributedText = FormatUtil.getDefaultAttributedText(initial: "Описание:", description: "\(movie.overview ?? "-")")
    releaseDateLabel.attributedText = FormatUtil.getDefaultAttributedText(initial: "Дата выхода:", description: "\(movie.releaseDate != nil ? dateFormatter.string(from: movie.releaseDate!) : "-")")

    if let genres = movie.genres {
      genresLabel.attributedText = FormatUtil.getDefaultAttributedText(initial: "Жанры:", description: "\(genres.getGenresText())")
    } else {
       genresLabel.attributedText = FormatUtil.getDefaultAttributedText(initial: "Жанры:", description: "-")
    }
    
    budgetLabel.attributedText = FormatUtil.getDefaultAttributedText(initial: "Бюджет:", description: "$\(FormatUtil.getFormattedAmount(amount: movie.budget ?? 0) ?? "-")")
    revenueLabel.attributedText = FormatUtil.getDefaultAttributedText(initial: "Доход:", description: "$\(FormatUtil.getFormattedAmount(amount: movie.revenue ?? 0) ?? "-")")
  }
}
