import SwiftUI
import ViewIsComming

struct RandomSquaresView: View {
    @State private var showView = true
    // Controls
    @State private var gridWidth: Double = 10
    @State private var gridHeight: Double = 10
    @State private var smoothness: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .randomSquares(
                                size: CGSize(width: gridWidth, height: gridHeight),
                                smoothness: smoothness
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Grid width slider
                VStack(alignment: .leading) {
                    Text("Grid Width: \(Int(gridWidth))")
                    Slider(value: $gridWidth, in: 5...30, step: 1)
                }
                // Grid height slider
                VStack(alignment: .leading) {
                    Text("Grid Height: \(Int(gridHeight))")
                    Slider(value: $gridHeight, in: 5...30, step: 1)
                }
                // Smoothness slider
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showView.toggle()
                }
            }) {
                Text("Toggle Transition")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("RandomSquares")
    }
}

#Preview {
    RandomSquaresView()
}
