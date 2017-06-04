//
//  ViewController.swift
//  MathQuiz
//
//  Created by Dean Silfen on 6/4/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit


let questionViewHeight = 120
let inputViewHeight = 32

class RootViewController: UIViewController, NumberInputCollectionViewControllerDelegate, GameStateDelegate {

  let gameState = GameState()
  var inputItems: [String] = []

  var questionLabel: UILabel?
  var inputLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let questionFrame = CGRect(
      x: 0,
      y: 0,
      width: Int(self.view.bounds.size.width),
      height: questionViewHeight
    )
    
    self.questionLabel = UILabel(frame: questionFrame)
    self.view.addSubview(self.questionLabel!)
    self.questionLabel?.text = self.gameState.currentQuestion()?.text
    
    let inputFrame = CGRect(
      x: 0,
      y: questionViewHeight,
      width: Int(self.view.bounds.size.width),
      height: inputViewHeight
    )

    self.inputLabel = UILabel(frame: inputFrame)
    self.view.addSubview(self.inputLabel!)
    
    self.gameState.delegate = self
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(
      width: 84,
      height: 84
    )
    
    flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
    let collectionViewController = NumberInputCollectionViewController(
      collectionViewLayout: flowLayout
    )
    collectionViewController.delegate = self

    self.addChildViewController(collectionViewController)
    self.view.addSubview(collectionViewController.view)
    let collectionViewHeight = (questionViewHeight + inputViewHeight)
    collectionViewController.view.frame = CGRect(
      x: 0,
      y: collectionViewHeight,
      width: Int(self.view.bounds.size.width),
      height: Int(self.view.bounds.size.height) - collectionViewHeight
    )
    collectionViewController.didMove(toParentViewController: self)
  }

  // MARK: NumberInputCollectionViewControllerDelegate
  
  func numberInputCollectionViewController(_ numberInputCollectionViewController: NumberInputCollectionViewController, didSelect select: NumberInputSelection) {
    switch select {
    case .number(let numberText):
      self.inputItems.append(numberText)
    case .delete:
      self.inputItems.removeFirst()
    }
    
    self.inputLabel?.text = self.inputItems.joined()
    self.gameState.attemptAnswer(self.inputItems.joined())
  }
  
  // MARK: GameStateDelegate
  
  func gameStateDidUpdate(state: GameState, win: Bool) {
    if let question = state.currentQuestion() {
      self.questionLabel?.text = question.text
      self.inputLabel?.text = ""
    }
  }
}

