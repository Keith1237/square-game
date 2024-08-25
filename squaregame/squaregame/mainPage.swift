import SwiftUI

struct MainPage: View {
    var username: String
    @State private var highScore: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, \(username)!")
                .font(.title)
                .padding()

            Text("High Score: \(highScore)")
                .font(.headline)
                .padding()

            NavigationLink(destination: ContentView(username: username, highScore: $highScore)) {
                Text("New Game")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                loadHighScore()
            }) {
                Text("Highscore")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                
            }) {
                Text("Leaderboard")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Main Menu")
        .onAppear {
            loadHighScore()
        }
    }

    func loadHighScore() {
        let savedScore = UserDefaults.standard.integer(forKey: "\(username)_highScore")
        highScore = savedScore
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(username: "PreviewUser")
    }
}
