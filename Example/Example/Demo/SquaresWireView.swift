import SwiftUI
import ViewIsComming

struct SquaresWireView: View {
    @State private var showView = true
    // Controls
    @State private var squares: Double = 10
    @State private var smoothness: Double = 1.6
    @State private var direction: SquaresWireDirection = .upRight
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .squaresWire(
                                squares: Int(squares),
                                direction: direction,
                                smoothness: smoothness
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Squares: \(Int(squares))")
                    Slider(value: $squares, in: 5...30, step: 1)
                }
                
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.1f")")
                    Slider(value: $smoothness, in: 0.5...2.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Direction: \(directionName(direction))")
                    Picker("Direction", selection: $direction) {
                        Text("Right →").tag(SquaresWireDirection.right)
                        Text("Left ←").tag(SquaresWireDirection.left)
                        Text("Down ↓").tag(SquaresWireDirection.down)
                        Text("Up ↑").tag(SquaresWireDirection.up)
                        Text("Down-Right ↘").tag(SquaresWireDirection.downRight)
                        Text("Down-Left ↙").tag(SquaresWireDirection.downLeft)
                        Text("Up-Right ↗").tag(SquaresWireDirection.upRight)
                        Text("Up-Left ↖").tag(SquaresWireDirection.upLeft)
                    }
                    .pickerStyle(.menu)
                }
            }
            .font(.caption)
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
    
    private func directionName(_ direction: SquaresWireDirection) -> String {
        switch direction {
        case .right: return "Right →"
        case .left: return "Left ←"
        case .down: return "Down ↓"
        case .up: return "Up ↑"
        case .downRight: return "Down-Right ↘"
        case .downLeft: return "Down-Left ↙"
        case .upRight: return "Up-Right ↗"
        case .upLeft: return "Up-Left ↖"
        }
    }
}

#Preview {
    SquaresWireView()
}
