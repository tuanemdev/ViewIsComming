import SwiftUI
import ViewIsComming

struct FadeGrayscaleView: View {
    @State private var showView = true
    // Controls
    @State private var intensity: Double = 0.3
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .fadeGrayscale(intensity: intensity)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Intensity slider
                VStack(alignment: .leading) {
                    Text("Intensity: \(intensity, specifier: "%.2f")")
                        .font(.caption)
                    Text("0.0 = direct grayscale, 0.9 = long grayscale phase")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Slider(value: $intensity, in: 0.0...0.9)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default (0.3)") {
                        intensity = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Direct (0.0)") {
                        intensity = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Long Phase (0.8)") {
                        intensity = 0.8
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
        .navigationTitle("FadeGrayscale")
    }
}

#Preview {
    FadeGrayscaleView()
}
