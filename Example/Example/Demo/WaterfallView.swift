import SwiftUI
import ViewIsComming

struct WaterfallView: View {
    @State private var showView = true
    // Controls
    @State private var speed: Double = 2.0
    @State private var amplitude: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .waterfall(
                                speed: speed,
                                amplitude: amplitude
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
                    Text("Speed: \(speed, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $speed, in: 0.1...5.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Amplitude: \(amplitude, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $amplitude, in: 0.0...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Gentle") {
                        speed = 1.0
                        amplitude = 0.05
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        speed = 2.0
                        amplitude = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Turbulent") {
                        speed = 4.0
                        amplitude = 0.3
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
        .navigationTitle("Waterfall")
    }
}

#Preview {
    WaterfallView()
}
