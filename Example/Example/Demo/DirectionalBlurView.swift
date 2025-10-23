import SwiftUI
import ViewIsComming

struct DirectionalBlurView: View {
    @State private var showView = true
    // Controls
    @State private var directionX: Double = 1.0
    @State private var directionY: Double = 0.0
    @State private var samples: Double = 15.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .directionalBlur(
                                direction: CGPoint(x: directionX, y: directionY),
                                samples: samples
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Direction X: \(directionX, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $directionX, in: -1.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Direction Y: \(directionY, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $directionY, in: -1.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Samples: \(Int(samples))")
                        .font(.caption)
                    Slider(value: $samples, in: 5...30, step: 1)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("→") {
                        directionX = 1.0
                        directionY = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↓") {
                        directionX = 0.0
                        directionY = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↗️") {
                        directionX = 0.7
                        directionY = -0.7
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↘️") {
                        directionX = 0.7
                        directionY = 0.7
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
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
        .navigationTitle("DirectionalBlur")
    }
}

#Preview {
    DirectionalBlurView()
}
