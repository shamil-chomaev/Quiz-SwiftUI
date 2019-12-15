//
//  ButtonModifier.swift
//  Quiz
//
//  Created by Dennis Parussini on 10.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import SwiftUI

struct AnswerButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 350, height: 60, alignment: .center)
            .background(Color(red: 12.0 / 255.0, green: 121.0 / 255.0, blue: 150.0 / 255.0))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

struct AnswerButton: View {
    @Binding var guessedCorrectly: Bool
    var quizManager: QuizManager
    var answer: Answer
    var onTap: () -> Void
    
    var body: some View {
        Button(answer.text) {
            self.guessedCorrectly = self.quizManager.checkAnswer(self.answer, to: self.quizManager.currentQuestion)
            self.onTap()
        }
        .modifier(AnswerButtonModifier())
    }
}

struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AnswerButton(guessedCorrectly: .constant(true), quizManager: QuizManager(), answer: Answer(text: "Hello"), onTap: {})
    }
}
