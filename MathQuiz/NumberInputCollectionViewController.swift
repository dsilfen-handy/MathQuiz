//
//  NumberInputCollectionViewController.swift
//  MathQuiz
//
//  Created by Dean Silfen on 6/4/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

enum NumberInputSelection {
  case delete
  case number(String)
}

protocol NumberInputCollectionViewControllerDelegate: class {
  func numberInputCollectionViewController(_ numberInputCollectionViewController: NumberInputCollectionViewController, didSelect select: NumberInputSelection)
}

private let reuseIdentifier = "SelectionCell"

class NumberInputCollectionViewController: UICollectionViewController {

  var delegate: NumberInputCollectionViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView?.backgroundColor = UIColor.blue
    self.collectionView?.register(
      UICollectionViewCell.self,
      forCellWithReuseIdentifier: reuseIdentifier
    )
    self.collectionView?.contentInset = UIEdgeInsets(
      top: 10,
      left: 10,
      bottom: 10,
      right: 10
    )
  }

  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }


  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 12
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    cell.backgroundColor = UIColor.white
    
    let label = self.makeLabelWith(text: "\(indexPath.row)")
    cell.contentView.addSubview(label)
    label.frame = cell.contentView.frame
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.delegate?.numberInputCollectionViewController(self, didSelect: NumberInputSelection.number("\(indexPath.row)"))
  }
  
  private func makeLabelWith(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textAlignment = NSTextAlignment.center
    return label
  }
}
