import SwiftUI
import ViewIsComming

struct TangentMotionBlurView: View {
    @State private var showView = true
    // Controls
    @State private var radius: Double = 1.0
    @State private var samples: Double = 10.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .tangentMotionBlur(
                                radius: radius,
                                samples: samples
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
                    Text("Radius: \(radius, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $radius, in: 0.1...2.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Samples: \(Int(samples))")
                        .font(.caption)
                    Slider(value: $samples, in: 5...30, step: 1)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        radius = 0.5
                        samples = 8.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        radius = 1.0
                        samples = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Intense") {
                        radius = 2.0
                        samples = 20.0
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
        .navigationTitle("TangentMotionBlur")
    }
}

#Preview {
    TangentMotionBlurView()
}
