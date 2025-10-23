import SwiftUI
import ViewIsComming

struct PolkaDotsCurtainView: View {
    @State private var showView = true
    @State private var dots: Double = 20.0
    @State private var centerX: Double = 0.5
    @State private var centerY: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .polkaDotsCurtain(
                                dots: dots,
                                center: CGPoint(x: centerX, y: centerY)
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Dots: \(Int(dots))")
                        .font(.caption)
                    Slider(value: $dots, in: 5.0...50.0, step: 1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Center X: \(centerX, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $centerX, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Center Y: \(centerY, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $centerY, in: 0.0...1.0)
                }
                
                HStack(spacing: 10) {
                    Button("Center") {
                        centerX = 0.5
                        centerY = 0.5
                        dots = 20.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Top Left") {
                        centerX = 0.0
                        centerY = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Bottom Right") {
                        centerX = 1.0
                        centerY = 1.0
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
        .navigationTitle("PolkaDotsCurtain")
    }
}

#Preview {
    PolkaDotsCurtainView()
}
