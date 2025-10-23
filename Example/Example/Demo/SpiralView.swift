import SwiftUI
import ViewIsComming

struct SpiralView: View {
    @State private var showView = true
    // Controls
    @State private var rotations: Double = 3.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .spiral(rotations: rotations)
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
                    Slider(value: $rotations, in: 1.0...10.0, step: 0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Loose") {
                        rotations = 1.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        rotations = 3.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Tight") {
                        rotations = 5.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Very Tight") {
                        rotations = 8.0
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
        .navigationTitle("Spiral")
    }
}

#Preview {
    SpiralView()
}
