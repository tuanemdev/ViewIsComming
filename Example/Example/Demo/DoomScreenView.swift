import SwiftUI
import ViewIsComming

struct DoomScreenView: View {
    @State private var showView = true
    // Controls
    @State private var bars: Double = 30.0
    @State private var amplitude: Double = 0.2
    @State private var noise: Double = 0.1
    @State private var frequency: Double = 6.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .doomScreen(
                                bars: Int(bars),
                                amplitude: amplitude,
                                noise: noise,
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
                    Text("Bars: \(Int(bars))")
                        .font(.caption)
                    Slider(value: $bars, in: 10.0...100.0, step: 1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Amplitude: \(amplitude, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $amplitude, in: 0.0...0.5)
                }
                
                VStack(alignment: .leading) {
                    Text("Noise: \(noise, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $noise, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Frequency: \(frequency, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $frequency, in: 1.0...20.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Classic") {
                        bars = 30.0
                        amplitude = 0.2
                        noise = 0.1
                        frequency = 6.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Smooth") {
                        bars = 50.0
                        amplitude = 0.1
                        noise = 0.05
                        frequency = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Chaotic") {
                        bars = 20.0
                        amplitude = 0.4
                        noise = 0.3
                        frequency = 4.0
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
        .navigationTitle("DoomScreen")
    }
}

#Preview {
    DoomScreenView()
}
