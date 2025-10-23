import SwiftUI
import ViewIsComming

struct HexagonalizeView: View {
    @State private var showView = true
    // Controls
    @State private var steps: Double = 50
    @State private var horizontalHexagons: Double = 20
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .hexagonalize(
                                steps: steps,
                                horizontalHexagons: horizontalHexagons
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Steps slider
                VStack(alignment: .leading) {
                    Text("Steps: \(Int(steps))")
                        .font(.caption)
                    Slider(value: $steps, in: 0...100, step: 1)
                }
                
                // Horizontal hexagons slider
                VStack(alignment: .leading) {
                    Text("Horizontal Hexagons: \(Int(horizontalHexagons))")
                        .font(.caption)
                    Slider(value: $horizontalHexagons, in: 5...40, step: 1)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        steps = 50
                        horizontalHexagons = 20
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Large Hexagons") {
                        steps = 30
                        horizontalHexagons = 10
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Small Hexagons") {
                        steps = 80
                        horizontalHexagons = 35
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
        .navigationTitle("Hexagonalize")
    }
}

#Preview {
    HexagonalizeView()
}
