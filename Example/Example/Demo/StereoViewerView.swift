import SwiftUI
import ViewIsComming

struct StereoViewerView: View {
    @State private var showView = true
    // Controls
    @State private var zoom: Double = 0.5
    @State private var cornerRadius: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .stereoViewer(
                                zoom: zoom,
                                cornerRadius: cornerRadius
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
                    Text("Zoom: \(zoom, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $zoom, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Corner Radius: \(cornerRadius, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $cornerRadius, in: 0.0...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        zoom = 0.3
                        cornerRadius = 0.05
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        zoom = 0.5
                        cornerRadius = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Dramatic") {
                        zoom = 0.8
                        cornerRadius = 0.2
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
        .navigationTitle("StereoViewer")
    }
}

#Preview {
    StereoViewerView()
}
