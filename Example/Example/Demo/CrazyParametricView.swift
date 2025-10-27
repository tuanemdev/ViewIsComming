import SwiftUI
import ViewIsComming

struct CrazyParametricView: View {
    @State private var showView = true
    // Controls
    @State private var outerRadius: Double = 4
    @State private var innerRadius: Double = 1
    @State private var waveIntensity: Double = 120
    @State private var waveSmooth: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .crazyParametric(
                                outerRadius: outerRadius,
                                innerRadius: innerRadius,
                                waveIntensity: waveIntensity,
                                waveSmooth: waveSmooth
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 10) {
                // Outer Radius slider
                VStack(alignment: .leading) {
                    Text("Outer Radius: \(outerRadius, specifier: "%.1f")")
                    Slider(value: $outerRadius, in: 1...10)
                }
                
                // Inner Radius slider
                VStack(alignment: .leading) {
                    Text("Inner Radius: \(innerRadius, specifier: "%.1f")")
                    Slider(value: $innerRadius, in: 0.5...5)
                }
                
                // Wave Intensity slider
                VStack(alignment: .leading) {
                    Text("Wave Intensity: \(Int(waveIntensity))")
                    Slider(value: $waveIntensity, in: 20...200)
                }
                
                // Wave Smooth slider
                VStack(alignment: .leading) {
                    Text("Wave Smooth: \(waveSmooth, specifier: "%.2f")")
                    Slider(value: $waveSmooth, in: 0.05...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        outerRadius = 4
                        innerRadius = 1
                        waveIntensity = 120
                        waveSmooth = 0.1
                    }
                    
                    Button("Gentle") {
                        outerRadius = 3
                        innerRadius = 2
                        waveIntensity = 60
                        waveSmooth = 0.5
                    }
                    
                    Button("Wild") {
                        outerRadius = 8
                        innerRadius = 1
                        waveIntensity = 180
                        waveSmooth = 0.05
                    }
                }
                .font(.default)
            }
            .font(.caption)
            .buttonStyle(.bordered)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
            Button(action: {
                withAnimation(.linear(duration: 1.0)) {
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
        .navigationTitle("CrazyParametric")
    }
}

#Preview {
    CrazyParametricView()
}
