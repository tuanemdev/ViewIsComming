import SwiftUI
import ViewIsComming

struct RotateScaleVanishView: View {
    @State private var showView = true
    // Controls
    @State private var rotations: Double = 2.0
    @State private var scaleAmount: Double = 0.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .rotateScaleVanish(
                                rotations: rotations,
                                scaleAmount: scaleAmount
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
                    Text("Rotations: \(rotations, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $rotations, in: 0.5...5.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Scale: \(scaleAmount, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $scaleAmount, in: 0.0...5.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Vanish") {
                        rotations = 2.0
                        scaleAmount = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Spin Out") {
                        rotations = 4.0
                        scaleAmount = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Explode") {
                        rotations = 3.0
                        scaleAmount = 5.0
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
        .navigationTitle("RotateScaleVanish")
    }
}

#Preview {
    RotateScaleVanishView()
}
