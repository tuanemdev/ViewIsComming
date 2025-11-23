import SwiftUI
import ViewIsComming

struct DoomScreenView: View {
    @State private var showView = true
    // Controls
    @State private var bars: Double = 50.0
    @State private var amplitude: Double = 4.0
    @State private var noise: Double = 0.3
    @State private var frequency: Double = 0.8
    @State private var dripScale: Double = 0.3
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    if showView {
                        Image(.haNoi)
                            .resizable()
                            .transition(
                                .doomScreen(
                                    bars: Int(bars),
                                    amplitude: amplitude,
                                    noise: noise,
                                    frequency: frequency,
                                    dripScale: dripScale
                                )
                            )
                    }
                }
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)
                
                Button {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        showView.toggle()
                    }
                } label: {
                    Text("Toggle Transition")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Preset buttons
                HStack(spacing: 30) {
                    Button("Classic") {
                        bars = 30.0
                        amplitude = 2.0
                        noise = 0.1
                        frequency = 0.5
                        dripScale = 0.5
                    }
                    
                    Button("Fast") {
                        bars = 50.0
                        amplitude = 4.0
                        noise = 0.3
                        frequency = 0.8
                        dripScale = 0.3
                    }
                    
                    Button("Chaotic") {
                        bars = 20.0
                        amplitude = 3.0
                        noise = 0.5
                        frequency = 0.3
                        dripScale = 0.8
                    }
                }
                .buttonStyle(.bordered)
                
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading) {
                        Text("Bars: \(Int(bars))")
                        Slider(value: $bars, in: 10.0...100.0, step: 1.0)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Amplitude: \(amplitude, specifier: "%.1f")")
                        Slider(value: $amplitude, in: 0.0...5.0)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Noise: \(noise, specifier: "%.2f")")
                        Slider(value: $noise, in: 0.0...1.0)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Frequency: \(frequency, specifier: "%.2f")")
                        Slider(value: $frequency, in: 0.1...2.0)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Drip Scale: \(dripScale, specifier: "%.2f")")
                        Slider(value: $dripScale, in: 0.0...1.0)
                    }
                }
                .font(.caption)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
            }
        }
        .padding()
        .navigationTitle("DoomScreen")
    }
}

#Preview {
    DoomScreenView()
}
