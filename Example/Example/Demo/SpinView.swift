import SwiftUI
import ViewIsComming

struct SpinView: View {
    @State private var showView = true
    // Controls
    @State private var rotations: Double = 3.0
    @State private var zoom: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .spin(
                                rotations: rotations,
                                zoom: zoom
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
                    Slider(value: $rotations, in: 0.5...10.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Zoom: \(zoom, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $zoom, in: 0.0...2.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Slow Spin") {
                        rotations = 1.0
                        zoom = 0.8
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        rotations = 3.0
                        zoom = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Tornado") {
                        rotations = 8.0
                        zoom = 0.1
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
        .navigationTitle("Spin")
    }
}

#Preview {
    SpinView()
}
