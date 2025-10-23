import SwiftUI
import ViewIsComming

struct LuminanceMeltView: View {
    @State private var showView = true
    // Controls
    @State private var direction: Double = 1.0
    @State private var threshold: Double = 0.5
    @State private var smoothness: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .luminanceMelt(
                                direction: direction,
                                threshold: threshold,
                                smoothness: smoothness
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
                    Text("Direction: \(direction > 0 ? "Down/Right" : "Up/Left") (\(direction, specifier: "%.0f"))")
                        .font(.caption)
                    Picker("Direction", selection: $direction) {
                        Text("Up/Left").tag(-1.0)
                        Text("Down/Right").tag(1.0)
                    }
                    .pickerStyle(.segmented)
                }
                
                VStack(alignment: .leading) {
                    Text("Threshold: \(threshold, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $threshold, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.01...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Sharp Down") {
                        direction = 1.0
                        threshold = 0.5
                        smoothness = 0.05
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        direction = 1.0
                        threshold = 0.5
                        smoothness = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Smooth Up") {
                        direction = -1.0
                        threshold = 0.5
                        smoothness = 0.3
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
        .navigationTitle("LuminanceMelt")
    }
}

#Preview {
    LuminanceMeltView()
}
