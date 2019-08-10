//
//  ContentView.swift
//  Quiz
//
//  Created by Dennis Parussini on 08.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var quizManager = QuizManager()
    
    @State private var guessedCorrectly = false {
        didSet {
            updateResult()
        }
    }
    @State private var result = ""
    @State private var questionsAsked = 0
    @State private var correctAnswers = 0
    
    var body: some View {
        VStack {
            Text(quizManager.currentQuestion.question)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            VStack {
                ForEach(quizManager.currentQuestion.possibleAnswers) { answer in
                    Button(answer.text) {
                        self.guessedCorrectly = self.quizManager.checkAnswer(answer, to: self.quizManager.currentQuestion)
                        self.loadNextRoundWithDelay(seconds: 2)
                    }
                    .modifier(AnswerButtonModifier())
                }
            }.padding()
                        
            Text(result)
            
            if questionsAsked == 4 {
                Button("Show Result") {

                    //                    self.resetViews()
                    //                    self.quizManager.getRandomQuestion()
                }
                .modifier(PlayAgainButtonModifier())
            }
        }
    }
    
    private func updateResult() {
        questionsAsked += 1
        if guessedCorrectly { correctAnswers += 1 }
        result = guessedCorrectly ? "Correct" : "Incorrect"
    }
    
    private func resetViews() {
        result = ""
    }
    
    private func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.resetViews()
            self.quizManager.getRandomQuestion()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
