//
//  Result.swift
//  Quiz
//
//  Created by Dennis Parussini on 10.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import SwiftUI

struct Result: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var score: Int
    
    var body: some View {
        ZStack {
            
            Color(red: 8.0 / 255.0, green: 43.0 / 255.0, blue: 62.0 / 255.0)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Way to go, you have")
                    .modifier(ResultTextModifier())
                Text("\(score)/4")
                    .modifier(ResultTextModifier())
                Text("correct")
                    .modifier(ResultTextModifier())
                
                Button("Dismiss") {
                    //Found the solution for dismissing the view online, but it feels kinda hacky. Isn't there a better/more elegant way?
                    self.presentationMode.value.dismiss()
                }
                .modifier(PlayAgainButtonModifier())
            }
            .padding()
        }
    }
}

#if DEBUG
struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result(score: 0)
    }
}
#endif
