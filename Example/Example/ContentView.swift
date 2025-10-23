import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Angular") {
                    AngularView()
                }
                NavigationLink("PinWheel") {
                    PinWheelView()
                }
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
