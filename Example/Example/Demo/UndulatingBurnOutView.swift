import SwiftUI
import ViewIsComming

struct UndulatingBurnOutView: View {
    @State private var showView = true
    // Controls
    @State private var smoothness: Double = 0.03
    @State private var centerX: Double = 0.5
    @State private var centerY: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .undulatingBurnOut(
                                smoothness: smoothness,
                                center: CGPoint(x: centerX, y: centerY)
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Smoothness slider
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.01...0.1)
                }
                
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
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Center") {
                        smoothness = 0.03
                        centerX = 0.5
                        centerY = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Top Left") {
                        smoothness = 0.05
                        centerX = 0.25
                        centerY = 0.25
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Smooth") {
                        smoothness = 0.08
                        centerX = 0.5
                        centerY = 0.5
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
        .navigationTitle("UndulatingBurnOut")
    }
}

#Preview {
    UndulatingBurnOutView()
}
