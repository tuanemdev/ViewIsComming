import SwiftUI
import ViewIsComming

struct CornerVanishView: View {
    @State private var showView = true
    // Controls
    @State private var cornerSize: Double = 0.3
    @State private var corner: Double = 0.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .cornerVanish(
                                cornerSize: cornerSize,
                                corner: Int(corner)
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
                    Text("Corner Size: \(cornerSize, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $cornerSize, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Corner: \(["Top-Left", "Top-Right", "Bottom-Right", "Bottom-Left"][Int(corner)])")
                        .font(.caption)
                    Slider(value: $corner, in: 0.0...3.0, step: 1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("↖️ TL") {
                        corner = 0.0
                        cornerSize = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↗️ TR") {
                        corner = 1.0
                        cornerSize = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↘️ BR") {
                        corner = 2.0
                        cornerSize = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↙️ BL") {
                        corner = 3.0
                        cornerSize = 0.4
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
        .navigationTitle("CornerVanish")
    }
}

#Preview {
    CornerVanishView()
}
