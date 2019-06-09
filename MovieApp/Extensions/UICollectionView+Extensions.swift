//
//  UICollectionView+Extensions.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
  public static var identifier: String { return String(describing: self) }
}


extension UICollectionView {
  public func register(_ cell: UICollectionViewCell.Type) {
    register(cell, forCellWithReuseIdentifier: cell.identifier)
  }
  
  
  public func dequeueReusableCell<CellClass: UICollectionViewCell>(of class: CellClass.Type, for indexPath: IndexPath, configure: (CellClass) -> Void) -> UICollectionViewCell {
    
    let cell = dequeueReusableCell(withReuseIdentifier: CellClass.identifier, for: indexPath)
    
    if let typedCell = cell as? CellClass {
      configure(typedCell)
    }
    
    return cell
  }
  
  public func register(_ cell: UICollectionViewCell.Type, kind: String) {
    register(cell, forSupplementaryViewOfKind: kind, withReuseIdentifier: cell.identifier)
  }
  
  public func dequeueReusableSupplementaryView<CellClass: UICollectionViewCell>(of class: CellClass.Type, for indexPath: IndexPath, kind: String, configure: (CellClass) -> Void) -> UICollectionReusableView {
    let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellClass.identifier, for: indexPath)
    
    if let typedCell = cell as? CellClass {
      configure(typedCell)
    }
    
    return cell
  }
}
