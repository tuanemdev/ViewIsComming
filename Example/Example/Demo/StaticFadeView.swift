import SwiftUI
import ViewIsComming

struct StaticFadeView: View {
    @State private var showView = true
    // Controls
    @State private var nNoisePixels: Double = 200.0
    @State private var staticLuminosity: Double = 0.8
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .staticFade(
                                nNoisePixels: nNoisePixels,
                                staticLuminosity: staticLuminosity
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Noise pixels slider
                VStack(alignment: .leading) {
                    Text("Noise Pixels: \(Int(nNoisePixels))")
                        .font(.caption)
                    Slider(value: $nNoisePixels, in: 50...500, step: 10)
                }
                
                // Static luminosity slider
                VStack(alignment: .leading) {
                    Text("Static Luminosity: \(staticLuminosity, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $staticLuminosity, in: 0.0...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        nNoisePixels = 200.0
                        staticLuminosity = 0.8
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Fine Noise") {
                        nNoisePixels = 400.0
                        staticLuminosity = 0.6
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Coarse Bright") {
                        nNoisePixels = 100.0
                        staticLuminosity = 1.0
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
        .navigationTitle("StaticFade")
    }
}

#Preview {
    StaticFadeView()
}
