//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Karol Kusowski on 05/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var userScore = 0
    @State private var questionCounter = 1
    @State private var showingResults = false
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .red], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag off")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                        }
                        .clipShape(.capsule)
                        .shadow(radius: 5)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical ,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Your score is \(userScore)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Text("Question: \(questionCounter)/\(8)")
                    .font(.caption)
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Current score: \(userScore)")
        }
        .alert("Game over!", isPresented: $showingResults){
            Button("New game", action: newGame)
        } message: {
            Text("Your final score was \(userScore)")
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct answer!"
            userScore += 1
        } else {
            scoreTitle = "Wrong! The correct answer is \(countries[correctAnswer])"
        }
        
        if questionCounter == 8 {
            showingResults = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func newGame() {
        questionCounter = 0
        userScore = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
