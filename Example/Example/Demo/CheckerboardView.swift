import SwiftUI
import ViewIsComming

struct CheckerboardView: View {
    @State private var showView = true
    // Controls
    @State private var tilesX: Double = 10.0
    @State private var tilesY: Double = 10.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .checkerboard(
                                tilesX: tilesX,
                                tilesY: tilesY
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
                    Text("Tiles X: \(Int(tilesX))")
                        .font(.caption)
                    Slider(value: $tilesX, in: 2...20, step: 1)
                }
                
                VStack(alignment: .leading) {
                    Text("Tiles Y: \(Int(tilesY))")
                        .font(.caption)
                    Slider(value: $tilesY, in: 2...20, step: 1)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Small") {
                        tilesX = 4.0
                        tilesY = 4.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        tilesX = 10.0
                        tilesY = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Large") {
                        tilesX = 16.0
                        tilesY = 16.0
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
        .navigationTitle("Checkerboard")
    }
}

#Preview {
    CheckerboardView()
}
