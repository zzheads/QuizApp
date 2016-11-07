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
    
    init(question: String, choices: [String], answer: Int, isAnswered: Bool = false) {
        self.question = question
        self.choices = choices
        self.answer = answer
        self.isAnswered = isAnswered
    }
}

class Quiz {
    var trivias: [Trivia]
    var triviaPool: [Trivia]
    var currentTrivia: Trivia
    var indexOfCurrentTrivia: Int
    var questionAsked = 0
    var rightAnswers = 0
    let numberOfQuestions: Int
    
    init(trivias: [Trivia], numberOfQuestions: Int) {
        self.trivias = trivias
        self.triviaPool = trivias
        self.indexOfCurrentTrivia = 0
        self.currentTrivia = trivias[self.indexOfCurrentTrivia]
        self.numberOfQuestions = numberOfQuestions
    }
    
    func getIndexOfCurrentTrivia() -> Int {
        return self.indexOfCurrentTrivia
    }
    
    // setups nextRound of Quiz
    func newRound() {
        let index = GKRandomSource.sharedRandom().nextInt(upperBound: triviaPool.count)
        self.indexOfCurrentTrivia = index
        self.currentTrivia = triviaPool[index]
        triviaPool.remove(at: index) // remove trivia from triviaPool to avoid repeats
    }
    
    // checks is Quiz finished yet
    func isFinished() -> Bool {
        return (questionAsked >= numberOfQuestions)
    }
    
    //skip question
    func skipQuestion() {
        questionAsked += 1
    }
    
    // check answer on current trivia and returns result and right answer in tuple
    func checkAnswer(answer: Int) -> (isRight: Bool, rightAnswer: Int) {
        questionAsked += 1
        if (answer == currentTrivia.answer) {
            rightAnswers += 1
            return (true, currentTrivia.answer)
        }
        return (false, currentTrivia.answer)
    }
    
    func restart() {
        for i in 0..<trivias.count {
            trivias[i].isAnswered = false
        }
        triviaPool = trivias
        questionAsked = 0
        rightAnswers = 0
    }
}

