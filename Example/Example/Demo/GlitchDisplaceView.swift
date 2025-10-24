import SwiftUI
import ViewIsComming

struct GlitchDisplaceView: View {
    @State private var showView = true
    // Controls
    @State private var intensity: Double = 0.5
    @State private var frequency: Double = 20.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .glitchDisplace(
                                intensity: intensity,
                                frequency: frequency
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
                    Text("Intensity: \(intensity, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $intensity, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Frequency: \(frequency, specifier: "%.0f")")
                        .font(.caption)
                    Slider(value: $frequency, in: 5.0...50.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Mild") {
                        intensity = 0.3
                        frequency = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        intensity = 0.5
                        frequency = 20.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Chaos") {
                        intensity = 0.8
                        frequency = 40.0
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
        .navigationTitle("GlitchDisplace")
    }
}

#Preview {
    GlitchDisplaceView()
}
