//
//  Result.swift
//  Quiz
//
//  Created by Dennis Parussini on 10.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import SwiftUI

struct Result: View {
    var score: Int
    
    var body: some View {
        VStack {
            Text("Way to go, you have")
                .font(.title)
                .padding()
            Text("\(score)/4")
                .font(.largeTitle)
                .padding()
            Text("correct")
                .font(.title)
                .padding()
        }.padding()
    }
}

#if DEBUG
struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result(score: 0)
    }
}
#endif
