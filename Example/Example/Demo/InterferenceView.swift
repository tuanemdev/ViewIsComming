import SwiftUI
import ViewIsComming

struct InterferenceView: View {
    @State private var showView = true
    // Controls
    @State private var frequency: Double = 20.0
    @State private var amplitude: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .interference(
                                frequency: frequency,
                                amplitude: amplitude
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
                    Text("Frequency: \(Int(frequency))")
                        .font(.caption)
                    Slider(value: $frequency, in: 1.0...50.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Amplitude: \(amplitude, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $amplitude, in: 0.1...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Gentle") {
                        frequency = 10.0
                        amplitude = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        frequency = 20.0
                        amplitude = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Intense") {
                        frequency = 40.0
                        amplitude = 0.8
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
        .navigationTitle("Interference")
    }
}

#Preview {
    InterferenceView()
}
