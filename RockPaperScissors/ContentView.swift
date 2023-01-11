//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Aktilek Ishanov on 08.01.2023.
//

import SwiftUI

struct ContentView: View {
    let moves = ["📜", "✂️", "🪨"]
    let winningMoves = ["🪨", "📜", "✂️"]
    @State private var appsMove = Int.random(in: 0...2)
    @State private var playersMove = ""
    @State private var shouldWin = Bool.random()
    @State private var isCorrectMove = false
    @State private var score = 0
    @State private var showingGameOver = false
    @State private var attempts = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text("Rock, Paper, Scissors")
                        .font(.title).bold()
                    HStack {
                        Text("App's move: \(moves[appsMove]) |")
                        shouldWin ?
                        Text("You should: Win") :
                        Text("You should: Lose")
                    }
                    .padding()
                    HStack{
                        ForEach(0..<3) { number in
                            Button {
                                moveTapped(number)
                            } label: {
                                Text("\(winningMoves[number])")
                                    .font(.system(size: 75))
                            }
                            .padding(5)
                        }
                    }
                    Text("Score: \(score) | Attempt: \(attempts)")
                        .padding(30)
                }
            }
            .foregroundStyle(.white)
        }
        .alert("Game Over", isPresented: $showingGameOver) {
            Button("Reset", action: resetGame)
        } message: {
            Text("Total score: \(score)")
        }
    }
    
    func moveTapped(_ number: Int) {
        playersMove = winningMoves[number]
        if !shouldWin {
            if appsMove == number {
                score += 1
                isCorrectMove = true
            } else {
                score -= 1
                isCorrectMove = false
            }
        } else {
            if appsMove != number {
                score += 1
                isCorrectMove = true
            } else {
                score -= 1
                isCorrectMove = false
            }
        }
        attempts += 1
        if attempts == 10 {
            showingGameOver = true
        }
        appsMove = Int.random(in: 0...2)
        shouldWin.toggle()
    }

    func resetGame(){
        score = 0
        attempts = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
