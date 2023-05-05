import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                
            VStack {
                Spacer()
                NavigationLink(destination: findroot()) {
                    Text("Go to Second View")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}
struct findroot: View {
    var body: some View {
        Text("Hello from Second View!")
            .navigationBarTitle("Second View")
    }
}
