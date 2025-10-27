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
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Center X
                VStack(alignment: .leading) {
                    Text("Center X: \(centerX, specifier: "%.2f")")
                    Slider(value: $centerX, in: 0.0...1.0)
                }
                // Center Y
                VStack(alignment: .leading) {
                    Text("Center Y: \(centerY, specifier: "%.2f")")
                    Slider(value: $centerY, in: 0.0...1.0)
                }
                // Threshold
                VStack(alignment: .leading) {
                    Text("Threshold: \(threshold, specifier: "%.1f")")
                    Slider(value: $threshold, in: 1.0...5.0)
                }
                // Fade edge
                VStack(alignment: .leading) {
                    Text("Fade Edge: \(fadeEdge, specifier: "%.2f")")
                    Slider(value: $fadeEdge, in: 0.0...0.5)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 1.5)) {
                    showView.toggle()
                }
            }) {
                Text(showView ? "Hide" : "Show")
                    .transaction { $0.animation = nil }
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
