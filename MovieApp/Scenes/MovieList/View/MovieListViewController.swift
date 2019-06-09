//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by asylzhan on 6/5/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit
import ViewAnimator
import RxSwift
import RxCocoa

protocol MovieListViewControllerDelegate: class {
  func didSelect(movie selectedMovie: Movie)
}

class MovieListViewController: UIViewController {
  
  // MARK: Properties
  fileprivate lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    cv.showsHorizontalScrollIndicator = false
    cv.dataSource = self
    cv.delegate = self
    cv.translatesAutoresizingMaskIntoConstraints = false
    return cv
  }()
  
  fileprivate lazy var emptyIconImageView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "clapperboard")
    imgView.contentMode = .scaleAspectFit
    imgView.isHidden = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    view.color = Colors.mainGrayColor
    view.hidesWhenStopped = true
    return view
  }()
  
  fileprivate let fromAnimation = AnimationType.from(direction: .bottom, offset: 30.0)
  fileprivate let zoomAnimation = AnimationType.zoom(scale: 0.9)
  
  fileprivate var movies = [Movie]() {
    didSet {
      collectionView.reloadData()
    }
  }
  
  fileprivate let searchBarController = CustomSearchController()
  
  var presenter: MoviePresentation?
  weak var delegate: MovieListViewControllerDelegate?
  
  fileprivate var tempMovies = [Movie]()
  private let space: CGFloat = 8.0
  private let minWidth: CGFloat = 175.5
  private let bag = DisposeBag()
  
  // MARK: View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
   
    setupViews()
    presenter?.fetchMovies()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    activityIndicator.center = CGPoint(x: collectionView.bounds.size.width / 2, y: collectionView.bounds.origin.y + 46)
  }
  
  // MARK: Setup
  private func setupViews() {
    view.backgroundColor = .white
    setupCollectionView()
    setupSearchBar()
    setupConstraints()
  }
  
  private func setupCollectionView() {
    collectionView.register(MoviePosterCell.self)
    let layout = UICollectionViewFlowLayout()
    
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    collectionView.setCollectionViewLayout(layout, animated: true)
    collectionView.alwaysBounceVertical = true
    collectionView.backgroundColor = .clear
    view.addSubview(collectionView)
    collectionView.addSubview(activityIndicator)
  }
  
  private func setupConstraints() {
    activate([collectionView.topAnchor.constraint(equalTo: view.topAnchor),
              collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
              collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
              collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)])
  }
  
  private func setupSearchBar() {
    navigationItem.titleView = searchBarController.searchBar
    searchBarController.hidesNavigationBarDuringPresentation = false
    searchBarController.searchBar.placeholder = "Поиск фильмов..."
    searchBarController.searchBar.autocapitalizationType = .none
    searchBarController.searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true

    let searchTextField = self.searchBarController.searchBar.value(forKey: "searchField") as? UITextField
    searchTextField?.layer.borderWidth = 1.0
    searchTextField?.layer.borderColor = UIColor(red: 157.0/255.0, green: 169.0/255.0, blue: 181.0/255.0, alpha: 1.0).cgColor
    searchTextField?.layer.masksToBounds = true
    searchTextField?.layer.cornerRadius = 8.0
    
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .defaultPrompt)
    setupAccessoryInput()
    bindSearchBar()
  }
  
  private func bindSearchBar() {
    searchBarController.searchBar.rx.text
      .asObservable()
      .skip(1)
      .debounce(0.4, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .filter { (text) -> Bool in
        guard let searchString = text else { return false }
        
        if searchString.isEmpty {
          self.movies = self.tempMovies
          return false
        }
        
        return true
      }
      .flatMapLatest { (query) -> Observable<[Movie]> in
        self.activityIndicator.startAnimating()
        return self.presenter!.searchMovie(by: query!)
      }
      .subscribe(onNext: { [weak self] (movies) in
        self?.activityIndicator.stopAnimating()
        self?.movies = movies
      })
      .disposed(by: bag)
  }
  
  private func setupAccessoryInput() {
    let toolbar = UIToolbar(frame: CGRect.init(x: 0.0, y: 0.0, width: view.frame.width, height: 44.0))
    let dismissButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(hideKeyboard))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    toolbar.items = [flexSpace, dismissButton]
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    toolbar.addGestureRecognizer(tapGestureRecognizer)
    
    searchBarController.searchBar.inputAccessoryView = toolbar
  }
  
  // MARK: Actions
  @objc fileprivate func hideKeyboard() {
    searchBarController.searchBar.resignFirstResponder()
  }
}

// MARK: - UICollectionView DataSource & Delegate
extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(of: MoviePosterCell.self, for: indexPath) { (cell) in
      let movie = movies[indexPath.row]
      cell.movie = movie
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let currentDevice = UIDevice.current
    
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
      let width = currentDevice.isPortrait ? (view.frame.width - 4.0 * space) / 3 : (view.frame.width - 5.0 * space) / 4
      return CGSize(width: (view.frame.width - 6.0 * space) / 3 , height: width * 1.45)
    default:
      let width = currentDevice.isPortrait ? (view.frame.width - 3.0 * space) / 2 : (view.frame.width - 4.0 * space) / 3
      return CGSize(width: width, height: width * 1.45)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    collectionView.collectionViewLayout.invalidateLayout()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelect(movie: movies[indexPath.row])
  }
}

// MARK: - MovieListView
extension MovieListViewController: MovieListView {
  func updateView(with movies: [Movie]) {
    self.movies = movies
    self.tempMovies = movies

    collectionView.alpha = 0
  
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      self.collectionView.alpha = 1.0
      UIView.animate(views: self.collectionView.orderedVisibleCells, animations: [self.zoomAnimation, self.fromAnimation], animationInterval: 0.2, duration: 0.7)
    }
  }
}
