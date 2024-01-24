//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Nikolai Grachev on 25.01.2024.
//

import SwiftUI

struct FlagImage: View {
     var imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}


