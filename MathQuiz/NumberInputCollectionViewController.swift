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
  case negate
  case number(String)
}

protocol NumberInputCollectionViewControllerDelegate: class {
  func numberInputCollectionViewController(_ numberInputCollectionViewController: NumberInputCollectionViewController, didSelect select: NumberInputSelection)
}

private let reuseIdentifier = "SelectionCell"

class NumberInputCollectionViewController: UICollectionViewController {

  var delegate: NumberInputCollectionViewControllerDelegate?
  var orderedValuesForCollectionItems: [String] = [
    "1", "2", "3",
    "4", "5", "6",
    "7", "8", "9",
    "-", "0", "⌫"
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView?.backgroundColor = UIColor.blue
    self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    self.collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
    
    let label = UILabel()
    label.text = self.orderedValuesForCollectionItems[indexPath.row]
    label.textAlignment = NSTextAlignment.center
    cell.contentView.addSubview(label)
    label.frame = cell.contentView.frame
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let value = self.orderedValuesForCollectionItems[indexPath.row]
    if !matches(for: "[0-9]", in: value).isEmpty {
      self.delegate?.numberInputCollectionViewController(self, didSelect: NumberInputSelection.number(value))
    } else if (!matches(for: "⌫", in: value).isEmpty) {
      self.delegate?.numberInputCollectionViewController(self, didSelect: NumberInputSelection.delete)
    } else {
      self.delegate?.numberInputCollectionViewController(self, didSelect: NumberInputSelection.negate)
    }
  }
  
  func matches(for regex: String, in text: String) -> [String] {
    
    do {
      let regex = try NSRegularExpression(pattern: regex)
      let nsString = text as NSString
      let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
      return results.map { nsString.substring(with: $0.range)}
    } catch let error {
      print("invalid regex: \(error.localizedDescription)")
      return []
    }
  }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
