import SwiftUI
import ViewIsComming

struct FlipView: View {
    @State private var showView = true
    // Controls
    @State private var axis: Double = 0.0
    @State private var perspective: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .flip(
                                axis: axis,
                                perspective: perspective
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
                    Text("Axis: \(axis < 0.5 ? "Horizontal" : "Vertical")")
                        .font(.caption)
                    Slider(value: $axis, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Perspective: \(perspective, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $perspective, in: 0.0...2.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Horizontal") {
                        axis = 0.0
                        perspective = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Vertical") {
                        axis = 1.0
                        perspective = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Dramatic") {
                        axis = 0.0
                        perspective = 1.5
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
        .navigationTitle("Flip")
    }
}

#Preview {
    FlipView()
}
