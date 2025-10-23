import SwiftUI
import ViewIsComming

struct RandomNoiseView: View {
    @State private var showView = true
    // Controls
    @State private var density: Double = 50.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .randomNoise(density: density)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Density: \(Int(density))")
                        .font(.caption)
                    Slider(value: $density, in: 10.0...200.0, step: 10.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Coarse") {
                        density = 20.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        density = 50.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Fine") {
                        density = 100.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Very Fine") {
                        density = 150.0
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
        .navigationTitle("RandomNoise")
    }
}

#Preview {
    RandomNoiseView()
}
