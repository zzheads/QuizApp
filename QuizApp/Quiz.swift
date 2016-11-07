//
//  Quiz.swift
//  QuizApp
//
//  Created by Alexey Papin on 05.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import GameKit

struct Trivia {
    let question: String
    let choices: [String]   // count 3-4
    let answer: Int         // 1-3, 1-4
    var isAnswered: Bool
    var isAsked: Bool
    
    init(question: String, choices: [String], answer: Int, isAnswered: Bool = false, isAsked: Bool = false) {
        self.question = question
        self.choices = choices
        self.answer = answer
        self.isAnswered = isAnswered
        self.isAsked = isAsked
    }    
}

class Quiz {
    var trivias: [Trivia]
    var indexOfCurrentTrivia: Int
    var questionAsked = 0
    var rightAnswers = 0
    let numberOfQuestions: Int
    
    init(trivias: [Trivia], numberOfQuestions: Int) {
        self.trivias = trivias
        self.indexOfCurrentTrivia = 0
        self.numberOfQuestions = numberOfQuestions
    }
    
    func getIndexOfCurrentTrivia() -> Int {
        return self.indexOfCurrentTrivia
    }
    
    func getCurrentTrivia() -> Trivia {
        return self.trivias[indexOfCurrentTrivia]
    }
    
    // setups nextRound of Quiz
    func newRound() {
        repeat {
            self.indexOfCurrentTrivia = GKRandomSource.sharedRandom().nextInt(upperBound: trivias.count)
        } while (self.trivias[indexOfCurrentTrivia].isAsked)
        trivias[indexOfCurrentTrivia].isAsked = true
    }
    
    // checks is Quiz finished yet
    func isFinished() -> Bool {
        return (questionAsked >= numberOfQuestions)
    }
    
    //skip question
    func skipQuestion() {
        self.trivias[indexOfCurrentTrivia].isAnswered = true
        self.questionAsked += 1
    }
    
    // check answer on current trivia and returns result and right answer in tuple
    func checkAnswer(answer: Int) -> (isRight: Bool, rightAnswer: Int) {
        self.trivias[indexOfCurrentTrivia].isAnswered = true
        questionAsked += 1
        if (answer == trivias[indexOfCurrentTrivia].answer) {
            rightAnswers += 1
            return (true, trivias[indexOfCurrentTrivia].answer)
        }
        return (false, trivias[indexOfCurrentTrivia].answer)
    }
    
    func restart() {
        for i in 0..<trivias.count {
            trivias[i].isAnswered = false
            trivias[i].isAsked = false
        }
        questionAsked = 0
        rightAnswers = 0
    }
}

