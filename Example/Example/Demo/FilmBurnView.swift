import SwiftUI
import ViewIsComming

struct FilmBurnView: View {
    @State private var showView = true
    // Controls
    @State private var burnSize: Double = 0.3
    @State private var intensity: Double = 1.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .filmBurn(
                                burnSize: burnSize,
                                intensity: intensity
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
                    Text("Burn Size: \(burnSize, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $burnSize, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Intensity: \(intensity, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $intensity, in: 0.0...2.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        burnSize = 0.1
                        intensity = 0.8
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        burnSize = 0.3
                        intensity = 1.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Intense") {
                        burnSize = 0.6
                        intensity = 2.0
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
        .navigationTitle("FilmBurn")
    }
}

#Preview {
    FilmBurnView()
}
