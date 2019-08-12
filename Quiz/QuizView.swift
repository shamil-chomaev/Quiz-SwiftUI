//
//  QuizView.swift
//  Quiz
//
//  Created by Dennis Parussini on 08.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject private var quizManager = QuizManager()
    
    @State private var guessedCorrectly = false {
        didSet {
            updateResult()
        }
    }
    
    @State private var result = ""
    @State private var questionsAsked = 0
    @State private var correctAnswers = 0
    @State private var showResult = false
    
    var body: some View {
        ZStack {
            Color(red: 8.0 / 255.0, green: 43.0 / 255.0, blue: 62.0 / 255.0)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(quizManager.currentQuestion.question)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                
                VStack {
                    ForEach(quizManager.currentQuestion.possibleAnswers) { answer in
                        Button(answer.text) {
                            self.guessedCorrectly = self.quizManager.checkAnswer(answer, to: self.quizManager.currentQuestion)
                        }
                        .modifier(AnswerButtonModifier())
                            
                            //Is this the correct way to present a new view? Are there other ways?
                        .popover(isPresented: self.$showResult) {
                            Result(score: self.correctAnswers)
                        }
                    }
                }
                .padding()
                
                Text(result)
                    .foregroundColor(.white)
            }
        }
    }
    
    //Where/how do I call this? I've tried adding a .onAppear modifier to the ZStack, but it wouldn't work that way.
    private func resetGame() {
        questionsAsked = 0
        correctAnswers = 0
        self.resetViews()
        self.quizManager.getRandomQuestion()
    }
    
    private func updateResult() {
        questionsAsked += 1
        if questionsAsked < 4 {
            if guessedCorrectly { correctAnswers += 1 }
            result = guessedCorrectly ? "Correct" : "Incorrect"
            loadNextRoundWithDelay(seconds: 2)
        } else {
            self.showResult.toggle()
        }
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
        QuizView()
    }
}
#endif