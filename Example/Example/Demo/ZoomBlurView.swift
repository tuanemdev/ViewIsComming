import SwiftUI
import ViewIsComming

struct ZoomBlurView: View {
    @State private var showView = true
    // Controls
    @State private var strength: Double = 0.3
    @State private var samples: Double = 10.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .zoomBlur(
                                strength: strength,
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
                    Text("Strength: \(strength, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $strength, in: 0.1...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Samples: \(Int(samples))")
                        .font(.caption)
                    Slider(value: $samples, in: 5.0...20.0, step: 1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        strength = 0.2
                        samples = 8.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        strength = 0.3
                        samples = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong") {
                        strength = 0.6
                        samples = 15.0
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
        .navigationTitle("ZoomBlur")
    }
}

#Preview {
    ZoomBlurView()
}
