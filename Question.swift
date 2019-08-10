//
//  Question.swift
//  Quiz
//
//  Created by Dennis Parussini on 10.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import Foundation

struct Question {
    var id: String = UUID().uuidString
    var question: String
    var answer: Answer
    var possibleAnswers: [Answer]
}

extension Question: Equatable {}

struct Answer: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var text: String
}
