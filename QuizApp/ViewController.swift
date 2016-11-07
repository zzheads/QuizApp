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
            
            Trivia(question: "This was the only US President to serve more than two consecutive terms.", choices: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson"], answer: 2),
            Trivia(question: "This was the only US President to serve more than two consecutive varms.", choices: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: 2),
            Trivia(question: "Which of the following countries has the most residents?", choices: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: 1),
            Trivia(question: "In what year was the United Nations founded?", choices: ["1918", "1919", "1945", "1954"], answer: 3),
            Trivia(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", choices: ["Paris", "Washington D.C.", "New York City", "Boston"], answer: 3),
            Trivia(question: "Which nation produces the most oil?", choices: ["Iran", "Iraq", "Brazil", "Canada"], answer: 4),
            Trivia(question: "Which country has most recently won consecutive World Cups in Soccer?", choices: ["Italy", "Brazil", "Argetina", "Spain"], answer: 2),
            Trivia(question: "Which of the following rivers is longest?", choices: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: 2),
            Trivia(question: "Which city is the oldest?", choices: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: 1),
            Trivia(question: "Which country was the first to allow women to vote in national elections?", choices: ["Poland", "United States", "Sweden", "Senegal"], answer: 1),
            Trivia(question: "Which of these countries won the most medals in the 2012 Summer Games?", choices: ["France", "Germany", "Japan", "Great Britian"], answer: 4),
            Trivia(question: "If you're short of a plot, why not brush up your Shakespeare? Which of these musicals was NOT inspired by a William Shakespeare play?", choices: ["A Funny Thing Happened on the Way to the Forum", "West Side Story", "Kiss Me Kate", "The Boys from Syracuse"], answer: 1),
            Trivia(question: "George Bernard Shaw's play 'Pygmalion' was itself an updating of a Greek legend. Who transformed it into the musical 'My Fair Lady'?", choices:["Richard Rodgers and Oscar Hammerstein", "Leonard Bernstein and Stephen Sondheim", "John Kander and Fred Ebb", "Alan Jay Lerner and Frederick Loewe"], answer: 4),
            Trivia(question: "The tale of an orphan boy who wanted more, which musical based on a Charles Dickens novel won an Oscar for Best Picture?", choices: ["Pickwick", "Drood", "Scrooge", "Oliver!"], answer: 4),
            Trivia(question: "Based on the novel 'Kipps' by H G Wells, which musical tells the tale of a draper's apprentice who inherits, and then loses, a fortune?", choices: ["The Most Happy Fella", "The Threepenny Opera", "Little Me", "Half a Sixpence"], answer: 4),
            Trivia(question: "'Jeeves', an early Andrew Lloyd Webber musical, was based on stories by which humorous writer, himself a sometime lyricist?", choices: ["P G Wodehouse", "A P Herbert", "T S Eliot", "W S Gilbert"], answer: 1),
            Trivia(question: "'Nights of Cabiria', winner of the Oscar for Best Foreign Language Film in 1958, is perhaps not the most obvious inspiration for a Broadway show. Directed by Federico Fellini, this tale of an Italian lady of the night and her vain search for love was transplanted to another part of the world for which stage and movie musical?",  choices: ["Miss Saigon", "Irma La Douce", "Sweet Charity", "Cabaret"], answer: 3),
            Trivia(question: "Comic strips can provide good material for musicals. Which of these cartoon characters is the only one not to see his or her name up in Broadway lights during the 20th century?", choices:["Oor Wullie", "Charlie Brown", "Little Orphan Annie", "Li'l Abner"], answer: 1),
             Trivia(question: "When you're Stephen Sondheim you can take inspiration from anywhere. Which of these gave him the idea for the musical 'Sunday in the Park with George'?",
                    choices: ["a French painting", "an Italian opera", "a Russian novel", "a German fairy tale"], answer: 1)
        ],
        numberOfQuestions: 5)
    
    let soundStart = Sound(name: "start")
    let soundCompleted = Sound(name: "gameover")
    let soundSuccess = Sound(name: "success")
    let soundFailure = Sound(name: "failure")
    let buttonBackgroundColor = UIColor(red: 10/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
    let playAgainBackgroundColor = UIColor(red: 1/255.0, green: 147/255.0, blue: 135/255.0, alpha: 1.0)
    let grayTitleColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 0.5)

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var buttons: [UIButton] = []
    let delayInSeconds = 2 // delay when checking answer / showing right one
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        soundStart.play()
        playNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
        buttonFlash(sender: sender)
        
        // pressed button #sender.tag
        // check answer
        let answerGiven = sender.tag + 1
    
        let result = quiz.checkAnswer(answer: answerGiven)
        if result.isRight {
            showMessage(typeOfMessage: .success)
            soundSuccess.play()
        } else {
            showMessage(typeOfMessage: .failure)
            soundFailure.play()
        }
        for i in 0..<buttons.count {
            if i != (result.rightAnswer - 1) {
                buttons[i].setTitleColor(grayTitleColor, for: .normal)
            }
        }
        showNextQuestionButton()
    }
    
    func makeButton(title: String, backgroundColor: UIColor, number: Int, numberMax: Int) -> UIButton {
        let yStart = 160//Int(successLabel.bounds.maxY + 20) // Y coord of start rect holding buttons
        let yEnd = Int(UIScreen.main.bounds.height - 90) // end Y coord of the rect
        let heightButtonWithMargin = (yEnd-yStart)/numberMax
        let widthOfButtons = Int(UIScreen.main.bounds.width) - 80
        let yStartButton = yStart + number * heightButtonWithMargin
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 40, y: yStartButton, width: widthOfButtons, height: 50)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 17.0)
        button.tag = number
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)

        return button
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
    
    func playNewRound() {
        hideMessage()
        quiz.newRound()
        questionLabel.text = quiz.getCurrentTrivia().question
        let numberChoices = quiz.getCurrentTrivia().choices.count
        for i in 0..<numberChoices {
            let button = makeButton(title: quiz.getCurrentTrivia().choices[i], backgroundColor: buttonBackgroundColor, number: i, numberMax: numberChoices)
            buttons.append(button)
            buttons[i].isHidden = false
        }
        hideControlButton()
        
        let timePerQuestion = 15
        let timeStartAlert = 9
        let index = quiz.getIndexOfCurrentTrivia()
        
        for i in (0..<timeStartAlert) {
            DispatchQueue.main.asyncAfter(deadline: (.now() + .seconds(timePerQuestion-timeStartAlert+i))) {
                if (self.quiz.trivias[index].isAsked)&&(!self.quiz.trivias[index].isAnswered) {
                    self.showMessage(typeOfMessage: .failure, text: "Left \(Int(timeStartAlert-i)) seconds...")
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timePerQuestion)) {
            if (self.quiz.trivias[index].isAsked)&&(!self.quiz.trivias[index].isAnswered) {
                self.showMessage(typeOfMessage: .failure, text: "Reseting question")
                self.quiz.skipQuestion()
                self.playNewRound()
                self.showMessage(typeOfMessage: .failure)
            }
        }
        
    }
    
    func playAgainPressed(sender: UIButton) {
        quiz.restart()
        hideControlButton()
        soundStart.play()
        playNewRound()
    }
    
    func nextQuestionPressed(sender: UIButton) {
        for button in buttons {
            button.removeFromSuperview()
            button.isHidden = true
        }
        buttons.removeAll()
        
        hideMessage()
        
        if quiz.questionAsked < quiz.numberOfQuestions {
            playNewRound()
        } else {
            // Game Over
            showPlayAgainButton()
            questionLabel.text = "You gave \(quiz.rightAnswers)/\(quiz.questionAsked) right answers!"
            soundCompleted.play()
        }
    }
    
    func showNextQuestionButton() {
        controlButton.setTitle("Next question", for: .normal)
        controlButton.removeTarget(self, action: #selector(playAgainPressed(sender:)), for: .touchUpInside)
        controlButton.addTarget(self, action: #selector(nextQuestionPressed(sender:)), for: .touchUpInside)
        controlButton.isEnabled = true
        controlButton.isHidden = false
    }
    
    func showPlayAgainButton() {
        controlButton.setTitle("Play again?", for: .normal)
        controlButton.removeTarget(self, action: #selector(nextQuestionPressed(sender:)), for: .touchUpInside)
        controlButton.addTarget(self, action: #selector(playAgainPressed(sender:)), for: .touchUpInside)
        controlButton.isEnabled = true
        controlButton.isHidden = false
    }
    
    func hideControlButton() {
        controlButton.removeTarget(self, action: #selector(nextQuestionPressed(sender:)), for: .touchUpInside)
        controlButton.removeTarget(self, action: #selector(playAgainPressed(sender:)), for: .touchUpInside)
        controlButton.isEnabled = false
        controlButton.isHidden = true
    }
    
    
    enum TypeOfMessage: String {
        case success = "Correct."
        case failure = "Sorry, that's not it."
    }
    
    func showMessage(typeOfMessage: TypeOfMessage, text: String? = nil) {
        let failureColor = UIColor(red: 255/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)
        let successColor = UIColor(red: 0/255.0, green: 128/255.0, blue: 64/255.0, alpha: 1.0)
        switch typeOfMessage {
            case .success: messageLabel.textColor = successColor
            case .failure: messageLabel.textColor = failureColor
        }
        if text == nil {
            messageLabel.text = typeOfMessage.rawValue
        } else {
            messageLabel.text = text
        }
        messageLabel.isHidden = false
    }
    
    func hideMessage() {
        messageLabel.isHidden = true
    }
    
}
