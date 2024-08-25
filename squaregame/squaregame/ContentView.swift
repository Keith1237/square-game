import SwiftUI

struct ContentView: View {
    var username: String
    @Binding var highScore: Int
    let baseColors: [Color] = [.red, .green, .blue, .yellow, .purple]
    @State private var colors: [Color] = []
    @State private var selectedColors: [Color] = []
    @State private var score: Int = 0
    @State private var gameOver: Bool = false
    @State private var remainingTime: Int = 30
    @State private var timer: Timer? = nil
    @Environment(\.presentationMode) var presentationMode // To programmatically go back

    init(username: String, highScore: Binding<Int>) {
        self.username = username
        self._highScore = highScore
        _colors = State(initialValue: generateRandomColors())
    }

    var body: some View {
        VStack {
            if gameOver {
                Text("Game Over")
                    .font(.largeTitle)
                    .padding()
            } else {
                Text("Time Remaining: \(remainingTime) seconds")
                    .font(.headline)
                    .padding()

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
                message: Text("Time's up or you clicked two buttons with different colors.\nYour final score is \(score)."),
                dismissButton: .default(Text("Return to Main Page"), action: {
                    updateHighScore()
                    presentationMode.wrappedValue.dismiss() // Navigate back to MainPage
                })
            )
        }
        .onAppear {
            startTimer()
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
                timer?.invalidate()
            }
            selectedColors.removeAll()
        }
    }

    func resetGame() {
        score = 0
        gameOver = false
        selectedColors.removeAll()
        colors = generateRandomColors()
        remainingTime = 30
        startTimer()
    }

    func generateRandomColors() -> [Color] {
        var randomColors = baseColors

        while randomColors.count < 9 {
            randomColors.append(baseColors.randomElement()!)
        }

        return randomColors.shuffled()
    }

    func startTimer() {
        timer?.invalidate()
        remainingTime = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                gameOver = true
                timer?.invalidate()
            }
        }
    }

    func updateHighScore() {
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "\(username)_highScore")
        }
    }
}
