import SwiftUI
import ViewIsComming

struct BounceView: View {
    @State private var showView = true
    // Controls
    @State private var bounces: Double = 4.0
    @State private var shadowAlpha: Double = 0.6
    @State private var shadowHeight: Double = 0.075
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .bounce(
                                bounces: bounces,
                                shadowAlpha: shadowAlpha,
                                shadowHeight: shadowHeight
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
                    Text("Bounces: \(Int(bounces))")
                        .font(.caption)
                    Slider(value: $bounces, in: 1.0...10.0, step: 1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Shadow Alpha: \(shadowAlpha, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $shadowAlpha, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Shadow Height: \(shadowHeight, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $shadowHeight, in: 0.0...0.3)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Gentle") {
                        bounces = 2.0
                        shadowAlpha = 0.4
                        shadowHeight = 0.05
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        bounces = 4.0
                        shadowAlpha = 0.6
                        shadowHeight = 0.075
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Energetic") {
                        bounces = 8.0
                        shadowAlpha = 0.8
                        shadowHeight = 0.1
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
        .navigationTitle("Bounce")
    }
}

#Preview {
    BounceView()
}
