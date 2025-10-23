import SwiftUI
import ViewIsComming

struct DirectionalEasingView: View {
    @State private var showView = true
    // Controls
    @State private var directionX: Double = 1.0
    @State private var directionY: Double = 0.0
    @State private var scale: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .directionalEasing(
                                direction: CGPoint(x: directionX, y: directionY),
                                scale: scale
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
                    Text("Scale: \(scale, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $scale, in: 0.0...2.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Right") {
                        directionX = 1.0
                        directionY = 0.0
                        scale = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Left") {
                        directionX = -1.0
                        directionY = 0.0
                        scale = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Down") {
                        directionX = 0.0
                        directionY = 1.0
                        scale = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Diagonal") {
                        directionX = 1.0
                        directionY = 1.0
                        scale = 0.5
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
        .navigationTitle("DirectionalEasing")
    }
}

#Preview {
    DirectionalEasingView()
}
