//
//  GameState.swift
//  MathQuiz
//
//  Created by Dean Silfen on 6/4/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

struct Question {
  let text: String
  let answer: String
}

protocol GameStateDelegate: class {
  func gameStateDidUpdate(state: GameState, win: Bool)
}

class GameState: NSObject {
  var unAnsweredQuestions = [
    Question(text: "2 + 2", answer: "4"),
    Question(text: "20 + 3", answer: "23"),
    Question(text: "4 + 4", answer: "8"),
    Question(text: "10 - 4", answer: "6"),
    Question(text: "1 + 1", answer: "2"),
  ]
  
  var answeredQuestions: [Question] = []
  
  var delegate: GameStateDelegate?
  
  public func currentQuestion() -> Question? {
    return self.unAnsweredQuestions.first
  }
  
  public func attemptAnswer(_ answer: String) {
    if self.currentQuestion()?.answer == answer {
      let question = self.unAnsweredQuestions.removeFirst()
      self.answeredQuestions.append(question)
      self.delegate?.gameStateDidUpdate(state: self, win: self.unAnsweredQuestions.isEmpty)
    }
  }
}
