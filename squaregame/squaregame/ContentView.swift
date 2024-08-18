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
    let baseColors: [Color] = [.red, .green, .blue, .yellow, .purple] 
    @State private var colors: [Color] = []
    @State private var selectedColors: [Color] = []
    @State private var score: Int = 0
    @State private var gameOver: Bool = false

    init() {
        _colors = State(initialValue: generateRandomColors())
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
                                .fill(colors[index])
                                .aspectRatio(1, contentMode: .fit)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .padding(10)
                .border(Color.black, width: 4)
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
                score += 1
                colors = generateRandomColors()
            } else {
                gameOver = true
            }
            selectedColors.removeAll()
        }
    }
    
    func resetGame() {
        score = 0
        gameOver = false
        selectedColors.removeAll()
        colors = generateRandomColors()
    }
    
    func generateRandomColors() -> [Color] {
        var randomColors = baseColors
        
        
        while randomColors.count < 9 {
            randomColors.append(baseColors.randomElement()!)
        }
        
        return randomColors.shuffled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




