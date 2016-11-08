//
//  GameQuiz.swift
//  QuizApp
//
//  Created by Alexey Papin on 08.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//


struct GameQuiz {
    
    let standartQuiz = Quiz(
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
            ], numberOfQuestions: 5)

    
    var quiz: Quiz
   
    enum GameMode: String {
        case standart = "Standart"
        case maths = "Maths"
    }
    
    var gameMode: GameMode = .standart
    
    init (gameMode: GameMode) {
        self.gameMode = gameMode
        switch gameMode {
        case .standart: self.quiz = standartQuiz
        case .maths: self.quiz = Quiz(trivias: getMathTrivias(numTrivias: 10), numberOfQuestions: 5)
        }
    }
    
    func getQuiz() -> Quiz {
        return quiz
    }
    
    mutating func switchGameMode(newMode: GameMode) {
        self.gameMode = newMode
    }
}
  
