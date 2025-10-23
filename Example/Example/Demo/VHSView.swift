import SwiftUI
import ViewIsComming

struct VHSView: View {
    @State private var showView = true
    // Controls
    @State private var glitchAmount: Double = 0.5
    @State private var lineHeight: Double = 0.005
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .vhs(
                                glitchAmount: glitchAmount,
                                lineHeight: lineHeight
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
                    Text("Glitch Amount: \(glitchAmount, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $glitchAmount, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Line Height: \(lineHeight, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $lineHeight, in: 0.001...0.05)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        glitchAmount = 0.2
                        lineHeight = 0.003
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Classic") {
                        glitchAmount = 0.5
                        lineHeight = 0.005
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Heavy") {
                        glitchAmount = 0.9
                        lineHeight = 0.01
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
        .navigationTitle("VHS")
    }
}

#Preview {
    VHSView()
}
