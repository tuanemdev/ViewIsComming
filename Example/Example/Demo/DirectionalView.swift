import SwiftUI
import ViewIsComming

struct DirectionalView: View {
    @State private var showView = true
    @State private var directionX: Double = 0.0
    @State private var directionY: Double = 1.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .directional(direction: CGVector(dx: directionX, dy: directionY))
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Direction X: \(directionX, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $directionX, in: -1.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Direction Y: \(directionY, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $directionY, in: -1.0...1.0)
                }
                
                HStack(spacing: 10) {
                    Button("→ Right") {
                        directionX = 1.0
                        directionY = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↑ Up") {
                        directionX = 0.0
                        directionY = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("← Left") {
                        directionX = -1.0
                        directionY = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("↓ Down") {
                        directionX = 0.0
                        directionY = -1.0
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
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
        .navigationTitle("Directional")
    }
}

#Preview {
    DirectionalView()
}
