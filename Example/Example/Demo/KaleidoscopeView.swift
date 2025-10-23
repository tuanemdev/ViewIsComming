import SwiftUI
import ViewIsComming

struct KaleidoscopeView: View {
    @State private var showView = true
    // Controls
    @State private var speed: Double = 1.0
    @State private var angle: Double = 1.0
    @State private var power: Double = 1.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .kaleidoscope(
                                speed: speed,
                                angle: angle,
                                power: power
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Speed slider
                VStack(alignment: .leading) {
                    Text("Speed: \(speed, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $speed, in: 0.1...5.0)
                }
                
                // Angle slider
                VStack(alignment: .leading) {
                    Text("Angle: \(angle, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $angle, in: 0.1...5.0)
                }
                
                // Power slider (segments)
                VStack(alignment: .leading) {
                    Text("Power (Segments): \(power, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $power, in: 1.0...8.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        speed = 1.0
                        angle = 1.0
                        power = 1.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Many Segments") {
                        speed = 1.5
                        angle = 2.0
                        power = 6.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Slow Spin") {
                        speed = 0.3
                        angle = 0.5
                        power = 3.0
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
        .navigationTitle("Kaleidoscope")
    }
}

#Preview {
    KaleidoscopeView()
}
