import SwiftUI
import ViewIsComming

struct GridFlipView: View {
    @State private var showView = true
    // Controls
    @State private var gridWidth: Double = 4
    @State private var gridHeight: Double = 4
    @State private var pause: Double = 0.1
    @State private var dividerWidth: Double = 0.05
    @State private var randomness: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .gridFlip(
                                size: CGSize(width: gridWidth, height: gridHeight),
                                pause: pause,
                                dividerWidth: dividerWidth,
                                randomness: randomness
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
                    Slider(value: $gridWidth, in: 2...10, step: 1)
                }
                
                // Grid height slider
                VStack(alignment: .leading) {
                    Text("Grid Height: \(Int(gridHeight))")
                        .font(.caption)
                    Slider(value: $gridHeight, in: 2...10, step: 1)
                }
                
                // Pause slider
                VStack(alignment: .leading) {
                    Text("Pause: \(pause, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $pause, in: 0.0...0.5)
                }
                
                // Divider width slider
                VStack(alignment: .leading) {
                    Text("Divider Width: \(dividerWidth, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $dividerWidth, in: 0.0...0.2)
                }
                
                // Randomness slider
                VStack(alignment: .leading) {
                    Text("Randomness: \(randomness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $randomness, in: 0.0...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        gridWidth = 4
                        gridHeight = 4
                        pause = 0.1
                        dividerWidth = 0.05
                        randomness = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Large Grid") {
                        gridWidth = 8
                        gridHeight = 8
                        pause = 0.15
                        randomness = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Slow") {
                        gridWidth = 3
                        gridHeight = 3
                        pause = 0.3
                        randomness = 0.05
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
        .navigationTitle("GridFlip")
    }
}

#Preview {
    GridFlipView()
}
