import SwiftUI
import ViewIsComming

struct ColorPhaseView: View {
    @State private var showView = true
    // Controls
    @State private var fromR: Double = 0.0
    @State private var fromG: Double = 0.2
    @State private var fromB: Double = 0.4
    @State private var toR: Double = 0.6
    @State private var toG: Double = 0.8
    @State private var toB: Double = 1.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .colorPhase(
                                fromStep: (r: fromR, g: fromG, b: fromB, a: 0.0),
                                toStep: (r: toR, g: toG, b: toB, a: 1.0)
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                Text("From Step (Start Phase)")
                    .font(.caption)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("R: \(fromR, specifier: "%.1f")")
                        .font(.caption2)
                    Slider(value: $fromR, in: 0.0...1.0)
                    
                    Text("G: \(fromG, specifier: "%.1f")")
                        .font(.caption2)
                    Slider(value: $fromG, in: 0.0...1.0)
                    
                    Text("B: \(fromB, specifier: "%.1f")")
                        .font(.caption2)
                    Slider(value: $fromB, in: 0.0...1.0)
                }
                
                Divider()
                
                Text("To Step (End Phase)")
                    .font(.caption)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("R: \(toR, specifier: "%.1f")")
                        .font(.caption2)
                    Slider(value: $toR, in: 0.0...1.0)
                    
                    Text("G: \(toG, specifier: "%.1f")")
                        .font(.caption2)
                    Slider(value: $toG, in: 0.0...1.0)
                    
                    Text("B: \(toB, specifier: "%.1f")")
                        .font(.caption2)
                    Slider(value: $toB, in: 0.0...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        fromR = 0.0; fromG = 0.2; fromB = 0.4
                        toR = 0.6; toG = 0.8; toB = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Quick") {
                        fromR = 0.0; fromG = 0.0; fromB = 0.0
                        toR = 1.0; toG = 1.0; toB = 1.0
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
        .navigationTitle("ColorPhase")
    }
}

#Preview {
    ColorPhaseView()
}
