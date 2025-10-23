import SwiftUI
import ViewIsComming

struct ZoomInCirclesView: View {
    @State private var showView = true
    // Controls
    @State private var speed: Double = 1.5
    @State private var density: Double = 10.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .zoomInCircles(
                                speed: speed,
                                density: density
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
                    Slider(value: $speed, in: 0.1...3.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Density: \(density, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $density, in: 1.0...20.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Sparse") {
                        speed = 1.0
                        density = 5.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        speed = 1.5
                        density = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Dense") {
                        speed = 2.0
                        density = 18.0
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
        .navigationTitle("ZoomInCircles")
    }
}

#Preview {
    ZoomInCirclesView()
}
