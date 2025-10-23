import SwiftUI
import ViewIsComming

struct ButterflyWaveScrawlerView: View {
    @State private var showView = true
    // Controls
    @State private var amplitude: Double = 1.0
    @State private var waves: Double = 30.0
    @State private var colorSeparation: Double = 0.3
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .butterflyWaveScrawler(
                                amplitude: amplitude,
                                waves: waves,
                                colorSeparation: colorSeparation
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Amplitude slider
                VStack(alignment: .leading) {
                    Text("Amplitude: \(amplitude, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $amplitude, in: 0.1...3.0)
                }
                
                // Waves slider
                VStack(alignment: .leading) {
                    Text("Waves: \(Int(waves))")
                        .font(.caption)
                    Slider(value: $waves, in: 10...60, step: 1)
                }
                
                // Color separation slider
                VStack(alignment: .leading) {
                    Text("Color Separation: \(colorSeparation, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $colorSeparation, in: 0.0...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        amplitude = 1.0
                        waves = 30.0
                        colorSeparation = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Subtle") {
                        amplitude = 0.5
                        waves = 20.0
                        colorSeparation = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Intense") {
                        amplitude = 2.5
                        waves = 50.0
                        colorSeparation = 0.6
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
        .navigationTitle("ButterflyWaveScrawler")
    }
}

#Preview {
    ButterflyWaveScrawlerView()
}
