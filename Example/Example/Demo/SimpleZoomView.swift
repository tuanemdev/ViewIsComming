import SwiftUI
import ViewIsComming

struct SimpleZoomView: View {
    @State private var showView = true
    
    // Controls
    @State private var zoomQuickness: Double = 0.8
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .simpleZoom(zoomQuickness: zoomQuickness)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Zoom Quickness: \(zoomQuickness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $zoomQuickness, in: 0.2...1.0)
                }
                
                Text("Controls how quickly the zoom effect happens. Lower values = slower zoom, Higher values = faster zoom.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Slow (0.3)") {
                        zoomQuickness = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Medium (0.6)") {
                        zoomQuickness = 0.6
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Fast (0.9)") {
                        zoomQuickness = 0.9
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
        .navigationTitle("SimpleZoom")
    }
}

#Preview {
    SimpleZoomView()
}
