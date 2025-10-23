import SwiftUI
import ViewIsComming

struct FlowerView: View {
    @State private var showView = true
    // Controls
    @State private var petals: Double = 6.0
    @State private var petalSize: Double = 0.2
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .flower(
                                petals: petals,
                                petalSize: petalSize
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
                    Text("Petals: \(Int(petals))")
                        .font(.caption)
                    Slider(value: $petals, in: 3.0...12.0, step: 1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Petal Size: \(petalSize, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $petalSize, in: 0.0...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Clover") {
                        petals = 4.0
                        petalSize = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Daisy") {
                        petals = 6.0
                        petalSize = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Sunflower") {
                        petals = 12.0
                        petalSize = 0.15
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
        .navigationTitle("Flower")
    }
}

#Preview {
    FlowerView()
}
