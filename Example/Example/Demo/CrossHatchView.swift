import SwiftUI
import ViewIsComming

struct CrossHatchView: View {
    @State private var showView = true
    // Controls
    @State private var centerX: Double = 0.5
    @State private var centerY: Double = 0.5
    @State private var threshold: Double = 3.0
    @State private var fadeEdge: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .crossHatch(
                                center: CGPoint(x: centerX, y: centerY),
                                threshold: threshold,
                                fadeEdge: fadeEdge
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Center X slider
                VStack(alignment: .leading) {
                    Text("Center X: \(centerX, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $centerX, in: 0.0...1.0)
                }
                
                // Center Y slider
                VStack(alignment: .leading) {
                    Text("Center Y: \(centerY, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $centerY, in: 0.0...1.0)
                }
                
                // Threshold slider
                VStack(alignment: .leading) {
                    Text("Threshold: \(threshold, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $threshold, in: 1.0...5.0)
                }
                
                // Fade edge slider
                VStack(alignment: .leading) {
                    Text("Fade Edge: \(fadeEdge, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $fadeEdge, in: 0.0...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Center") {
                        centerX = 0.5
                        centerY = 0.5
                        threshold = 3.0
                        fadeEdge = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Top Left") {
                        centerX = 0.25
                        centerY = 0.25
                        threshold = 2.5
                        fadeEdge = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Bottom Right") {
                        centerX = 0.75
                        centerY = 0.75
                        threshold = 3.5
                        fadeEdge = 0.15
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
        .navigationTitle("CrossHatch")
    }
}

#Preview {
    CrossHatchView()
}
