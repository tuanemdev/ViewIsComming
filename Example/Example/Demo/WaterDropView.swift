import SwiftUI
import ViewIsComming

struct WaterDropView: View {
    @State private var showView = true
    @State private var amplitude: Double = 0.04
    @State private var speed: Double = 20.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .waterDrop(
                                amplitude: amplitude,
                                speed: speed
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Amplitude: \(amplitude, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $amplitude, in: 0.01...0.15)
                }
                
                VStack(alignment: .leading) {
                    Text("Speed: \(speed, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $speed, in: 10.0...50.0)
                }
                
                HStack(spacing: 10) {
                    Button("Subtle") {
                        amplitude = 0.02
                        speed = 15.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        amplitude = 0.04
                        speed = 20.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong") {
                        amplitude = 0.08
                        speed = 35.0
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
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
        .navigationTitle("WaterDrop")
    }
}

#Preview {
    WaterDropView()
}
