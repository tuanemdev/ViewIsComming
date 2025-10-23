import SwiftUI
import ViewIsComming

struct PerlinView: View {
    @State private var showView = true
    // Controls
    @State private var scale: Double = 4.0
    @State private var smoothness: Double = 0.01
    @State private var seed: Double = 12.9898
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .perlin(
                                scale: scale,
                                smoothness: smoothness,
                                seed: seed
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Scale slider
                VStack(alignment: .leading) {
                    Text("Scale: \(scale, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $scale, in: 1.0...10.0)
                }
                
                // Smoothness slider
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.001...0.1)
                }
                
                // Seed slider
                VStack(alignment: .leading) {
                    Text("Seed: \(seed, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $seed, in: 0.0...100.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        scale = 4.0
                        smoothness = 0.01
                        seed = 12.9898
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Fine Noise") {
                        scale = 8.0
                        smoothness = 0.005
                        seed = 25.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Coarse Noise") {
                        scale = 2.0
                        smoothness = 0.05
                        seed = 50.0
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
        .navigationTitle("Perlin")
    }
}

#Preview {
    PerlinView()
}
