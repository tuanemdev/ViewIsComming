import SwiftUI
import ViewIsComming

struct SquaresWireView: View {
    @State private var showView = true
    // Controls
    @State private var squares: CGFloat = 10
    @State private var smoothness: Double = 1.6
    @State private var directionX: Double = 1.0
    @State private var directionY: Double = -0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Color.red
                        .transition(
                            .squaresWire(
                                squares: CGSize(width: squares, height: squares),
                                direction: CGPoint(x: directionX, y: directionY),
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
                    Text("Squares: \(Int(squares))")
                        .font(.caption)
                    Slider(value: $squares, in: 5...30, step: 1)
                }
                
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.1...3.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Direction X: \(directionX, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $directionX, in: -2...2)
                }
                
                VStack(alignment: .leading) {
                    Text("Direction Y: \(directionY, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $directionY, in: -2...2)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
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
        .navigationTitle("SquaresWire")
    }
}

#Preview {
    SquaresWireView()
}
