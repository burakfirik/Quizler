//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let allQuestions = QuestionBank()
  var pickedAnswer: Bool = false
  var index = 0
  var correct = 0
  
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var progressBar: UIView!
  @IBOutlet weak var progressLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nextQuestion()
    progressLabel.text = "1/\(allQuestions.list.count)"
    scoreLabel.text = "Score: 0"
    
  }
  
  
  @IBAction func answerPressed(_ sender: AnyObject) {
    if sender.tag == 1 {
      pickedAnswer = true
    } else if sender.tag == 2 {
      pickedAnswer = false
    }
    checkAnswer()
    index += 1
    nextQuestion()
    
  }
  
  
  func updateUI() {
    scoreLabel.text = "Score: \(correct)"
    progressLabel.text = "\(index + 1) / \(allQuestions.list.count)"
    progressBar.frame.size.width = (view.frame.size.width) / 13 * CGFloat(index)
  }
  
  func nextQuestion() {
    if index < allQuestions.list.count {
      questionLabel.text = allQuestions.list[index].questionText
      updateUI()
    } else {
      let alert = UIAlertController(title: "Awesome ", message: "You have finished all the questions, do you want to start over ?", preferredStyle: .alert)
      let startAction = UIAlertAction(title: "Restart", style: .default, handler: { (action) in
        self.startOver()
      })
      alert.addAction(startAction)
      present(alert, animated: true, completion: nil)
      
    }
  }
  
  
  func checkAnswer() {
    if allQuestions.list[index].answer == pickedAnswer {
      ProgressHUD.showSuccess("Corrent")
      correct += 1
    } else {
      ProgressHUD.showError("Wrong!")
    }
  }
  
  
  func startOver() {
    index = 0
    correct = 0
    nextQuestion()
  }
}
