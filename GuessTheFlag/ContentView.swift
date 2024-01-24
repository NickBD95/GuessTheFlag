//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nikolai Grachev on 18.01.2024.
//

import SwiftUI

struct LargeIndigoTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.indigo)
            .font(.largeTitle.weight(.bold))
    }
}

extension View {
    func largeIndigoTitle() -> some View {
        modifier(LargeIndigoTitle())
    }
}


struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var endOfTheGame = false
    
    @State private var countOfTheGame = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .largeIndigoTitle()
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTaped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action:  score >= 0 ? askQuestion : gameOver)
        } message: {
            Text(score >= 0 ? "Your score is \(score)" : "Game over")
        }
        
        .alert("End of the game", isPresented: $endOfTheGame) {
            Button("Finish", action: gameOver)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTaped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, it's flag of the \(countries[number])"
            score -= 1
        }
        
        if countOfTheGame != 8 {
            showingScore = true
            countOfTheGame += 1
        }
        
        if countOfTheGame == 8 {
            endOfTheGame = true
            countOfTheGame = 0
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func gameOver() {
        askQuestion()
        score = 0
        countOfTheGame = 0
    }
    
}
#Preview {
    ContentView()
}


