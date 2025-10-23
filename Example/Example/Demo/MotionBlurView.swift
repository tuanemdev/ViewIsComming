import SwiftUI
import ViewIsComming

struct MotionBlurView: View {
    @State private var showView = true
    // Controls
    @State private var angle: Double = 0.0
    @State private var samples: Double = 10.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .motionBlur(
                                angle: angle,
                                samples: Int(samples)
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
                    Slider(value: $angle, in: 0.0...360.0, step: 15.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Samples: \(Int(samples))")
                        .font(.caption)
                    Slider(value: $samples, in: 3.0...20.0, step: 1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("→") {
                        angle = 0.0
                        samples = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↓") {
                        angle = 90.0
                        samples = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↗️") {
                        angle = 315.0
                        samples = 15.0
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
        .navigationTitle("MotionBlur")
    }
}

#Preview {
    MotionBlurView()
}
