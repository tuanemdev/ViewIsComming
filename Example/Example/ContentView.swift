import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("SquaresWire") {
                    SquaresWireView()
                }
            }
            .navigationTitle("View Is Comming")
        }
    }
}

#Preview {
    ContentView()
}
