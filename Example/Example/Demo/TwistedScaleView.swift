import SwiftUI
import ViewIsComming

struct TwistedScaleView: View {
    @State private var showView = true
    // Controls
    @State private var rotations: Double = 2.0
    @State private var scale: Double = 0.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .twistedScale(
                                rotations: rotations,
                                scale: scale
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
                    Slider(value: $rotations, in: 0.1...5.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Scale: \(scale, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $scale, in: 0.0...2.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Vanish") {
                        rotations = 3.0
                        scale = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        rotations = 2.0
                        scale = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Expand") {
                        rotations = 1.5
                        scale = 1.5
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
        .navigationTitle("TwistedScale")
    }
}

#Preview {
    TwistedScaleView()
}
