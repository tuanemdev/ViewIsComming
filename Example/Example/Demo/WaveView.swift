import SwiftUI
import ViewIsComming

struct WaveView: View {
    @State private var showView = true
    // Controls
    @State private var amplitude: Double = 0.1
    @State private var waves: Double = 5.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .wave(
                                amplitude: amplitude,
                                waves: waves
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
                    Text("Amplitude: \(amplitude, specifier: "%.2f")")
                    Slider(value: $amplitude, in: 0.01...0.3)
                }
                
                VStack(alignment: .leading) {
                    Text("Waves: \(Int(waves))")
                    Slider(value: $waves, in: 1.0...15.0, step: 1.0)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
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
        .navigationTitle("Wave")
    }
}

#Preview {
    WaveView()
}
