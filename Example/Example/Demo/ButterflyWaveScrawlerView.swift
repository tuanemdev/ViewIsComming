import SwiftUI
import ViewIsComming

struct ButterflyWaveScrawlerView: View {
    @State private var showView = true
    // Controls
    @State private var amplitude: Double = 1.0
    @State private var waves: Double = 30.0
    @State private var colorSeparation: Double = 0.3
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .butterflyWaveScrawler(
                                amplitude: amplitude,
                                waves: waves,
                                colorSeparation: colorSeparation
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Amplitude: \(amplitude, specifier: "%.1f")")
                    Slider(value: $amplitude, in: 0.1...3.0)
                }
                VStack(alignment: .leading) {
                    Text("Waves: \(Int(waves))")
                    Slider(value: $waves, in: 10...60, step: 1)
                }
                VStack(alignment: .leading) {
                    Text("Color Separation: \(colorSeparation, specifier: "%.2f")")
                    Slider(value: $colorSeparation, in: 0.0...1.0)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
            Button(action: {
                withAnimation(.smooth(duration: 4.0)) {
                    showView.toggle()
                }
            }) {
                Text(showView ? "Hide" : "Show")
                    .transaction { $0.animation = nil }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("ButterflyWaveScrawler")
    }
}

#Preview {
    ButterflyWaveScrawlerView()
}
