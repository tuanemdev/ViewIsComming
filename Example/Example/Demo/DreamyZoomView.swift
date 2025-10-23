import SwiftUI
import ViewIsComming

struct DreamyZoomView: View {
    @State private var showView = true
    // Controls
    @State private var rotation: Double = 0.0
    @State private var scale: Double = 2.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .dreamyZoom(
                                rotation: rotation,
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
                    Text("Rotation: \(rotation, specifier: "%.2f") rad")
                        .font(.caption)
                    Slider(value: $rotation, in: -3.14...3.14)
                }
                
                VStack(alignment: .leading) {
                    Text("Scale: \(scale, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $scale, in: 1.0...5.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("No Rotation") {
                        rotation = 0.0
                        scale = 2.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        rotation = 0.6
                        scale = 2.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Heavy") {
                        rotation = 1.5
                        scale = 3.5
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
        .navigationTitle("DreamyZoom")
    }
}

#Preview {
    DreamyZoomView()
}
