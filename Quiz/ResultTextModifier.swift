//
//  ResultTextModifier.swift
//  Quiz
//
//  Created by Dennis Parussini on 10.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import SwiftUI

struct ResultTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding()
            .foregroundColor(.white)
    }
}
