import SwiftUI
import ViewIsComming

struct SwapView: View {
    @State private var showView = true
    // Controls
    @State private var reflection: Double = 0.4
    @State private var perspective: Double = 0.4
    @State private var depth: Double = 3.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .swap(
                                reflection: reflection,
                                perspective: perspective,
                                depth: depth
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
                    Text("Reflection: \(reflection, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $reflection, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Perspective: \(perspective, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $perspective, in: 0.0...2.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Depth: \(depth, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $depth, in: 0.5...10.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        reflection = 0.2
                        perspective = 0.2
                        depth = 2.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        reflection = 0.4
                        perspective = 0.4
                        depth = 3.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Dramatic") {
                        reflection = 0.8
                        perspective = 1.5
                        depth = 8.0
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
        .navigationTitle("Swap")
    }
}

#Preview {
    SwapView()
}
