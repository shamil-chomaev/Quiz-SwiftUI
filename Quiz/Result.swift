//
//  Result.swift
//  Quiz
//
//  Created by Dennis Parussini on 10.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import SwiftUI

struct Result: View {
    @Binding var isPresented: Bool
    
    var score: Int
    
    var body: some View {
        ZStack {
            Color(red: 8.0 / 255.0, green: 43.0 / 255.0, blue: 62.0 / 255.0)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("Way to go, you have")
                    Text("\(score)/4")
                    Text("correct")
                }
                .modifier(ResultTextModifier())
                
                PlayAgainButton(isResultPresented: $isPresented)
            }
            .padding()
        }
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result(isPresented: .constant(true), score: 0)
    }
}
