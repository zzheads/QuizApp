//
//  MathTrivia.swift
//  QuizApp
//
//  Created by Alexey Papin on 08.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import GameKit

enum Brackets: Int {
    case bracketsIn1 = 0
    case bracketsIn2 = 1
    case bracketsIn3 = 2
    case noBrackets = 3
}

enum Sign: String {
    case plus = "+"
    case minus = "-"
    case multiply = "*"
}

func generateBrackets() -> Brackets {
    let raw = GKRandomSource.sharedRandom().nextInt(upperBound: 4)
    switch raw {
    case 0: return .bracketsIn1
    case 1: return .bracketsIn2
    case 2: return .bracketsIn3
    default: return .noBrackets
    }
}

func generateSign() -> Sign {
    switch GKRandomSource.sharedRandom().nextInt(upperBound: 3) {
    case 0: return .minus
    case 1: return .multiply
    default: return .plus
    }
}

func generateInt(max: Int) -> Int {
    return (GKRandomSource.sharedRandom().nextInt(upperBound: max) + 1)
}

func generateFakeResult(result: Int) -> Int {
    if (Int(result) == 0) {
        return generateInt(max: 20)
    }
    var fakeResult: Int
    repeat {
        fakeResult = generateInt(max: result * 2)
    } while (Int(fakeResult) == Int(result))
    return fakeResult
}

func generateMathTrivia() -> Trivia {
    // Generate random maths trivia looks like:
    // [param1(#1)param2](#2)param3(#3)param4, where [] - random '()', # - random operation and params - random numbers 0..19
    let brackets: Brackets = generateBrackets()
    let sign1: Sign = generateSign()
    let sign2: Sign = generateSign()
    let sign3: Sign = generateSign()
    let param1: Int = generateInt(max: 19)
    let param2: Int = generateInt(max: 19)
    let param3: Int = generateInt(max: 19)
    let param4: Int = generateInt(max: 19)
    
    var mathString: String
    switch brackets {
    case .bracketsIn1: mathString = "(\(param1)\(sign1.rawValue)\(param2))\(sign2.rawValue)\(param3)\(sign3.rawValue)\(param4)"
    case .bracketsIn2: mathString = "\(param1)\(sign1.rawValue)(\(param2)\(sign2.rawValue)\(param3))\(sign3.rawValue)\(param4)"
    case .bracketsIn3: mathString = "\(param1)\(sign1.rawValue)\(param2)\(sign2.rawValue)(\(param3)\(sign3.rawValue)\(param4))"
    case .noBrackets: mathString = "\(param1)\(sign1.rawValue)\(param2)\(sign2.rawValue)\(param3)\(sign3.rawValue)\(param4)"
    }
    
    let exp: NSExpression = NSExpression(format: mathString)
    let result: Int = exp.expressionValue(with: nil, context: nil) as! Int
    let rightResult = String(result)
    let numberRightAnswer = generateInt(max: 4)
    
    var choices: [String] = []
    for i in 0..<4 {
        if (i == numberRightAnswer - 1) {
            choices.append(rightResult)
        } else {
            choices.append(String(generateFakeResult(result: result)))
        }
    }
    let trivia = Trivia(question: mathString, choices: choices, answer: numberRightAnswer)
    return trivia
}

func getMathTrivias(numTrivias: Int) -> [Trivia] {
    var result: [Trivia] = []
    for i in 0...numTrivias {
        let trivia = generateMathTrivia()
        print("Made \(i)/\(numTrivias) trivias")
        result.append(trivia)
    }
    return result
}

