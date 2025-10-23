import SwiftUI
import ViewIsComming

struct CircularScaleView: View {
    @State private var showView = true
    // Controls
    @State private var scale: Double = 0.0
    @State private var smoothness: Double = 0.3
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .circularScale(
                                scale: scale,
                                smoothness: smoothness
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
                    Text("Scale: \(scale, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $scale, in: 0.0...2.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Vanish") {
                        scale = 0.0
                        smoothness = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Shrink") {
                        scale = 0.5
                        smoothness = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Expand") {
                        scale = 2.0
                        smoothness = 0.5
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
        .navigationTitle("CircularScale")
    }
}

#Preview {
    CircularScaleView()
}
