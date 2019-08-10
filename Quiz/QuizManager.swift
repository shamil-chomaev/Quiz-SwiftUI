//
//  QuizManager.swift
//  Quiz
//
//  Created by Dennis Parussini on 08.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import GameKit
import Combine

class QuizManager: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    //Properties to keep track of question index and questions already asked
    private var questionsUsed = [Question]()
    
    //Arrays for questions and answers
    private var questions = [
        Question(question: "When was Apple Inc. founded?", answer: Answer(text: "1976"), possibleAnswers: [Answer(text: "1975"), Answer(text: "1976"), Answer(text: "1977")]),
        Question(question: "Which was NOT among the first computers Apple built?", answer: Answer(text: "Macintosh"), possibleAnswers: [Answer(text: "Apple I"), Answer(text: "Macintosh"), Answer(text: "Apple Lisa"), Answer(text: "Apple II")]),
        Question(question: "How many Steves were involved in the foundation of Apple Inc.?", answer: Answer(text: "2"), possibleAnswers: [Answer(text: "1"), Answer(text: "2"), Answer(text: "3"), Answer(text: "None")]),
        Question(question: "When was the first iPhone announced?", answer: Answer(text: "2007"), possibleAnswers: [Answer(text: "2006"), Answer(text: "2007"), Answer(text: "2008")]),
        Question(question: "How many iPhone apps are on the App Store?", answer: Answer(text: "More than a million"), possibleAnswers: [Answer(text: "A few thousand"), Answer(text: "More than a hundred thousand"), Answer(text: "More than a million")]),
        Question(question: "What was Steve Jobs' middlename?", answer: Answer(text: "Paul"), possibleAnswers: [Answer(text: "Paul"), Answer(text: "Peter"), Answer(text: "Pablo")]),
        Question(question: "When was the first iPad announced?", answer: Answer(text: "2010"), possibleAnswers: [Answer(text: "2008"), Answer(text: "2009"), Answer(text: "2010"), Answer(text: "2011")])
    ]
    
    var currentQuestion = Question(question: "", answer: Answer(text: ""), possibleAnswers: []) {
        didSet {
            didChange.send()
        }
    }
    
    init() {
        getRandomQuestion()
    }
    
    //Function which returns a random question and checks if the question has been asked before
    func getRandomQuestion() {
        guard var randomQuestion = questions.shuffled().first else { return }
        
        if questionsUsed.isEmpty || !questionsUsed.contains(randomQuestion) {
            questionsUsed.append(randomQuestion)
            currentQuestion = randomQuestion
        } else {
            for question in questionsUsed {
                while randomQuestion == question {
                    randomQuestion = questions.shuffled().first!
                    questionsUsed.append(randomQuestion)
                    currentQuestion = randomQuestion
                }
            }
        }
    }
    
    //Helper method to create a random integer
    func createRandomInt() -> Int {
        return GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    }
    
    //Function to check user's guess
    func checkAnswer(_ answer: Answer, to question: Question) -> Bool {
        return answer.text == question.answer.text
    }
}
