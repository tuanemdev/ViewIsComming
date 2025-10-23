import SwiftUI
import ViewIsComming

struct InvertedPageCurlView: View {
    @State private var showView = true
    // Controls
    @State private var angle: Double = 135.0
    @State private var radius: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .invertedPageCurl(
                                angle: angle,
                                radius: radius
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
                    Text("Angle: \(Int(angle))°")
                        .font(.caption)
                    Slider(value: $angle, in: 0...360, step: 15)
                }
                
                VStack(alignment: .leading) {
                    Text("Radius: \(radius, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $radius, in: 0.01...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("↗️ 45°") {
                        angle = 45.0
                        radius = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↘️ 135°") {
                        angle = 135.0
                        radius = 0.15
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↙️ 225°") {
                        angle = 225.0
                        radius = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↖️ 315°") {
                        angle = 315.0
                        radius = 0.1
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
        .navigationTitle("InvertedPageCurl")
    }
}

#Preview {
    InvertedPageCurlView()
}
