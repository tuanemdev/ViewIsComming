import SwiftUI
import ViewIsComming

struct PolarFunctionView: View {
    @State private var showView = true
    // Controls
    @State private var segments: Double = 5.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .polarFunction(segments: segments)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Segments slider
                VStack(alignment: .leading) {
                    Text("Segments: \(Int(segments))")
                        .font(.caption)
                    Slider(value: $segments, in: 1...12, step: 1)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default (5)") {
                        segments = 5.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Star (8)") {
                        segments = 8.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Flower (10)") {
                        segments = 10.0
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
        .navigationTitle("PolarFunction")
    }
}

#Preview {
    PolarFunctionView()
}
