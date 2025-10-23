import SwiftUI
import ViewIsComming

struct FlyEyeView: View {
    @State private var showView = true
    // Controls
    @State private var eyeSize: Double = 0.04
    @State private var zoom: Double = 50.0
    @State private var colorSeparation: Double = 0.3
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .flyEye(
                                size: eyeSize,
                                zoom: zoom,
                                colorSeparation: colorSeparation
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Eye size slider
                VStack(alignment: .leading) {
                    Text("Eye Size: \(eyeSize, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $eyeSize, in: 0.01...0.1)
                }
                
                // Zoom slider
                VStack(alignment: .leading) {
                    Text("Zoom: \(Int(zoom))")
                        .font(.caption)
                    Slider(value: $zoom, in: 10...100, step: 1)
                }
                
                // Color separation slider
                VStack(alignment: .leading) {
                    Text("Color Separation: \(colorSeparation, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $colorSeparation, in: 0.0...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        eyeSize = 0.04
                        zoom = 50.0
                        colorSeparation = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Fine Grid") {
                        eyeSize = 0.02
                        zoom = 80.0
                        colorSeparation = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Coarse Grid") {
                        eyeSize = 0.08
                        zoom = 30.0
                        colorSeparation = 0.5
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
        .navigationTitle("FlyEye")
    }
}

#Preview {
    FlyEyeView()
}
