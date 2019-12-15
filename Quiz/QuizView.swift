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
    
    @State private var guessedCorrectly = false
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
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                
                Spacer()
                
                VStack {
                    ForEach(quizManager.currentQuestion.possibleAnswers) { answer in
                        AnswerButton(guessedCorrectly: self.$guessedCorrectly, quizManager: self.quizManager, answer: answer) {
                            self.updateResult()
                        }
                        .popover(isPresented: self.$showResult) {
                            Result(isPresented: self.$showResult, score: self.correctAnswers)
                                .onDisappear {
                                    self.resetGame()
                            }
                        }
                    }
                    .padding()
                }
                
                Text(result)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func resetGame() {
        questionsAsked = 0
        correctAnswers = 0
        self.resetViews()
        self.quizManager.getRandomQuestion()
    }
    
    private func updateResult() {
        if guessedCorrectly {
            correctAnswers += 1
            Sound.playRightAnswerSound()
        } else {
            
            Sound.playWrongAnswerSound()
        }
        result = guessedCorrectly ? "Correct" : "Incorrect"
        questionsAsked += 1
        if questionsAsked == 4 {
            self.showResult.toggle()
        } else {
            loadNextRoundWithDelay(seconds: 1.5)
        }
    }
    
    private func resetViews() {
        result = ""
    }
    
    private func loadNextRoundWithDelay(seconds: Double) {
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.resetViews()
            self.quizManager.getRandomQuestion()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
