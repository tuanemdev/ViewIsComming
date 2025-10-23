import SwiftUI
import ViewIsComming

struct RotateScaleFadeView: View {
    @State private var showView = true
    // Controls
    @State private var centerX: Double = 0.5
    @State private var centerY: Double = 0.5
    @State private var rotations: Double = 1.0
    @State private var scale: Double = 8.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .rotateScaleFade(
                                center: CGPoint(x: centerX, y: centerY),
                                rotations: rotations,
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
                // Center X slider
                VStack(alignment: .leading) {
                    Text("Center X: \(centerX, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $centerX, in: 0.0...1.0)
                }
                
                // Center Y slider
                VStack(alignment: .leading) {
                    Text("Center Y: \(centerY, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $centerY, in: 0.0...1.0)
                }
                
                // Rotations slider
                VStack(alignment: .leading) {
                    Text("Rotations: \(rotations, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $rotations, in: -5.0...5.0)
                }
                
                // Scale slider
                VStack(alignment: .leading) {
                    Text("Scale: \(scale, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $scale, in: 1.0...15.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        centerX = 0.5
                        centerY = 0.5
                        rotations = 1.0
                        scale = 8.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Spin In") {
                        centerX = 0.5
                        centerY = 0.5
                        rotations = 3.0
                        scale = 12.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Reverse Spin") {
                        centerX = 0.5
                        centerY = 0.5
                        rotations = -2.0
                        scale = 5.0
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
        .navigationTitle("RotateScaleFade")
    }
}

#Preview {
    RotateScaleFadeView()
}
