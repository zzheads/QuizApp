//
//  ViewController.swift
//  QuizApp
//
//  Created by Alexey Papin on 05.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let quiz = Quiz(
        trivias: [
            Trivia(question: "This was the only US President to serve more than two consecutive terms.", choices: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: 2),
            Trivia(question: "Which of the following countries has the most residents?", choices: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: 1),
            Trivia(question: "In what year was the United Nations founded?", choices: ["1918", "1919", "1945", "1954"], answer: 3),
            Trivia(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", choices: ["Paris", "Washington D.C.", "New York City", "Boston"], answer: 3),
            Trivia(question: "Which nation produces the most oil?", choices: ["Iran", "Iraq", "Brazil", "Canada"], answer: 4),
            Trivia(question: "Which country has most recently won consecutive World Cups in Soccer?", choices: ["Italy", "Brazil", "Argetina", "Spain"], answer: 2),
            Trivia(question: "Which of the following rivers is longest?", choices: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: 2),
            Trivia(question: "Which city is the oldest?", choices: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: 1),
            Trivia(question: "Which country was the first to allow women to vote in national elections?", choices: ["Poland", "United States", "Sweden", "Senegal"], answer: 1),
            Trivia(question: "Which of these countries won the most medals in the 2012 Summer Games?", choices: ["France", "Germany", "Japan", "Great Britian"], answer: 4)
        ],
        numberOfQuestions: 5)
    
    let soundStart = Sound(name: "start")
    let soundCompleted = Sound(name: "completed")
    let soundSuccess = Sound(name: "success")
    let soundFailure = Sound(name: "failure")

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    @IBOutlet weak var choiceButton3: UIButton!
    @IBOutlet weak var choiceButton4: UIButton!
    
    var buttons: [UIButton] = []
    let delayInSeconds = 2 // delay when checking answer / showing right one
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playAgainButton.isHidden = true
        quitButton.isHidden = true
        
        buttons.append(choiceButton1)
        buttons.append(choiceButton2)
        buttons.append(choiceButton3)
        buttons.append(choiceButton4)
        
        runNextRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func runNextRound() {
        quiz.newRound()
        questionLabel.text = quiz.currentTrivia.question
        choiceButton1.setTitle(quiz.currentTrivia.choices[0], for: UIControlState.normal)
        choiceButton2.setTitle(quiz.currentTrivia.choices[1], for: UIControlState.normal)
        choiceButton3.setTitle(quiz.currentTrivia.choices[2], for: UIControlState.normal)
        choiceButton4.setTitle(quiz.currentTrivia.choices[3], for: UIControlState.normal)
    }
    
    func showResults() {
        questionLabel.text = " Questions asked: \(quiz.questionAsked),\n Right answers received: \(quiz.rightAnswers)"
        for button in buttons {
            button.isHidden = true
        }
        playAgainButton.isHidden = false
        quitButton.isHidden = false
        soundCompleted.play()
    }
    
    func checkAnswer(answer: Int) {
        let result = quiz.checkAnswer(answer: answer)
        buttonFlash(sender: buttons[result.rightAnswer-1])
        if (!result.isRight) { // we gave wrong answer, lets show right one
            soundFailure.play()
        } else {
            soundSuccess.play()
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        quiz.restart()
        playAgainButton.isHidden = true
        quitButton.isHidden = true
        for button in buttons {
            button.isHidden = false
        }
        runNextRound()
        soundStart.play()
    }
    
    @IBAction func quitApp(_ sender: Any) {
        exit(0)
    }
    

    @IBAction func choice1(_ sender: Any) {
        checkAnswer(answer: 1)
        if (!quiz.isFinished()) {
            runNextRound()
        } else {
            showResults()
        }
    }
    
    @IBAction func choice2(_ sender: Any) {
        checkAnswer(answer: 2)
        if (!quiz.isFinished()) {
            runNextRound()
        } else {
            showResults()
        }
    }
    
    @IBAction func choice3(_ sender: Any) {
        checkAnswer(answer: 3)
        if (!quiz.isFinished()) {
            runNextRound()
        } else {
            showResults()
        }
    }
    
    @IBAction func choice4(_ sender: Any) {
        checkAnswer(answer: 4)
        if (!quiz.isFinished()) {
            runNextRound()
        } else {
            showResults()
        }
    }
    
    func buttonFlash(sender: UIButton) {
        let bounds = sender.bounds
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 7.0,
            options: [.curveEaseInOut, .curveLinear, .beginFromCurrentState],
            animations: {
                sender.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y - 20, width: bounds.size.width + 60, height: bounds.size.height + 30)
                sender.isEnabled = false
            },
            completion: nil
        )
        
        sender.bounds = CGRect(x: Double(bounds.origin.x), y: Double(bounds.origin.y), width: Double(bounds.size.width), height: Double(bounds.size.height))
        sender.isEnabled = true
    }
    
}
