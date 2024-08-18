//
//  ContentView.swift
//  squaregame
//
//  Created by Keith Praveen on 2024-08-17.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
import SwiftUI

struct ContentView: View {
    let baseColors: [Color] = [.red, .green, .blue, .yellow, .purple] // Five colors to be used across nine buttons
    @State private var colors: [Color] = [] // Track current colors on buttons
    @State private var selectedColors: [Color] = [] // Track selected colors
    @State private var score: Int = 0 // Track the score
    @State private var gameOver: Bool = false // Track if the game is over

    init() {
        _colors = State(initialValue: generateRandomColors()) // Initialize colors array with random colors
    }

    var body: some View {
        VStack {
            if gameOver {
                Text("Game Over")
                    .font(.largeTitle)
                    .padding()
            } else {
                Text("Score: \(score)")
                    .font(.headline)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(0..<9) { index in
                        Button(action: {
                            handleButtonClick(color: colors[index])
                        }) {
                            Rectangle()
                                .fill(colors[index]) // Fill with current color
                                .aspectRatio(1, contentMode: .fit) // Makes the button a square
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .padding(10) // Padding inside the border
                .border(Color.black, width: 4) // Add a single border around the entire grid
            }
        }
        .padding()
        .alert(isPresented: $gameOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("You clicked two buttons with different colors."),
                dismissButton: .default(Text("Try Again"), action: resetGame)
            )
        }
    }
    
    func handleButtonClick(color: Color) {
        selectedColors.append(color)
        
        if selectedColors.count == 2 {
            if selectedColors[0] == selectedColors[1] {
                score += 1 // Increase score if colors match
                colors = generateRandomColors() // Refresh the colors randomly
            } else {
                gameOver = true // End the game if colors don't match
            }
            selectedColors.removeAll() // Reset the selection after each pair of clicks
        }
    }
    
    func resetGame() {
        score = 0
        gameOver = false
        selectedColors.removeAll()
        colors = generateRandomColors() // Reset the colors to a new random arrangement
    }
    
    func generateRandomColors() -> [Color] {
        var randomColors = baseColors // Start with the base colors
        
        // Add random elements to make up the remaining 4 slots
        while randomColors.count < 9 {
            randomColors.append(baseColors.randomElement()!)
        }
        
        return randomColors.shuffled() // Shuffle the colors array
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




