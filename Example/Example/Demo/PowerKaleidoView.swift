import SwiftUI
import ViewIsComming

struct PowerKaleidoView: View {
    @State private var showView = true
    // Controls
    @State private var speed: Double = 2.0
    @State private var angle: Double = 0.0
    @State private var power: Double = 2.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .powerKaleido(
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
                VStack(alignment: .leading) {
                    Text("Speed: \(speed, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $speed, in: 0.0...10.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Angle: \(Int(angle))°")
                        .font(.caption)
                    Slider(value: $angle, in: 0.0...360.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Power: \(Int(power)) segments")
                        .font(.caption)
                    Slider(value: $power, in: 1.0...8.0, step: 1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Simple") {
                        speed = 1.0
                        angle = 0.0
                        power = 2.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Complex") {
                        speed = 3.0
                        angle = 45.0
                        power = 4.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Crazy") {
                        speed = 6.0
                        angle = 90.0
                        power = 6.0
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
        .navigationTitle("PowerKaleido")
    }
}

#Preview {
    PowerKaleidoView()
}
