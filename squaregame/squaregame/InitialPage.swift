import SwiftUI

struct InitialPage: View {
    @State private var username: String = ""
    @State private var navigateToMainPage = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to the Game!")
                    .font(.largeTitle)
                    .padding()

                TextField("Enter your username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    navigateToMainPage = true
                }) {
                    Text("Go to Main Page")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(username.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(username.isEmpty) 
            }
            .padding()
            .navigationTitle("Initial Page")
            .navigationDestination(isPresented: $navigateToMainPage) {
                MainPage(username: username)
            }
        }
    }
}

struct InitialPage_Previews: PreviewProvider {
    static var previews: some View {
        InitialPage()
    }
}
