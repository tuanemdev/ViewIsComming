import SwiftUI
import ViewIsComming

struct WaveView: View {
    @State private var showView = true
    // Controls
    @State private var amplitude: Double = 0.1
    @State private var waves: Double = 5.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .wave(
                                amplitude: amplitude,
                                waves: waves
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
                    Text("Amplitude: \(amplitude, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $amplitude, in: 0.01...0.3)
                }
                
                VStack(alignment: .leading) {
                    Text("Waves: \(Int(waves))")
                        .font(.caption)
                    Slider(value: $waves, in: 1.0...15.0, step: 1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Gentle") {
                        amplitude = 0.05
                        waves = 3.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        amplitude = 0.1
                        waves = 5.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong") {
                        amplitude = 0.2
                        waves = 10.0
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
        .navigationTitle("Wave")
    }
}

#Preview {
    WaveView()
}
