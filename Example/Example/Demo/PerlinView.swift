import SwiftUI
import ViewIsComming

struct PerlinView: View {
    @State private var showHaNoi = true
    @State private var scale: Double = 4.0
    @State private var smoothness: Double = 0.01
    @State private var seed: Double = 12.9898
    
    var body: some View {
        ScrollView {
            ZStack {
                if showHaNoi {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .perlin(scale: scale, smoothness: smoothness, seed: seed),
                                removal: .none
                            )
                        )
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .perlin(scale: scale, smoothness: smoothness, seed: seed),
                                removal: .none
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Scale: \(scale, specifier: "%.1f")")
                    Slider(value: $scale, in: 1.0...10.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.3f")")
                    Slider(value: $smoothness, in: 0.001...0.1)
                }
                
                VStack(alignment: .leading) {
                    Text("Seed: \(seed, specifier: "%.2f")")
                    Slider(value: $seed, in: 0.0...100.0)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showHaNoi.toggle()
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
        .navigationTitle("Perlin")
    }
}

#Preview {
    PerlinView()
}
