import SwiftUI
import ViewIsComming

struct RotateView: View {
    @State private var showView = true
    // Controls
    @State private var rotations: Double = 1.0 // Number of full rotations
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .rotate(angle: .pi * 2 * rotations)
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
                    Slider(value: $rotations, in: 0.25...4.0, step: 0.25)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Quarter") {
                        rotations = 0.25
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Half") {
                        rotations = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("One") {
                        rotations = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Double") {
                        rotations = 2.0
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
        .navigationTitle("Rotate")
    }
}

#Preview {
    RotateView()
}
