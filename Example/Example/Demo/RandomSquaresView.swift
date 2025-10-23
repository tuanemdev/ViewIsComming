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
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Grid width slider
                VStack(alignment: .leading) {
                    Text("Grid Width: \(Int(gridWidth))")
                        .font(.caption)
                    Slider(value: $gridWidth, in: 5...30, step: 1)
                }
                
                // Grid height slider
                VStack(alignment: .leading) {
                    Text("Grid Height: \(Int(gridHeight))")
                        .font(.caption)
                    Slider(value: $gridHeight, in: 5...30, step: 1)
                }
                
                // Smoothness slider
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Fine Grid") {
                        gridWidth = 20
                        gridHeight = 20
                        smoothness = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Coarse Grid") {
                        gridWidth = 5
                        gridHeight = 5
                        smoothness = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Smooth") {
                        gridWidth = 15
                        gridHeight = 15
                        smoothness = 0.8
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 1.5)) {
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
