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
            .fixedSize()
            .padding()
            .background(Color(red: 12.0 / 255.0, green: 121.0 / 255.0, blue: 150.0 / 255.0))
            .foregroundColor(.white)
            .cornerRadius(8.0)
    }
}
