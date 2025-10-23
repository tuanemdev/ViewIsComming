import SwiftUI
import ViewIsComming

struct CrazyParametricFunView: View {
    @State private var showView = true
    // Controls
    @State private var a: Double = 4
    @State private var b: Double = 1
    @State private var amplitude: Double = 120
    @State private var smoothness: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .crazyParametricFun(
                                a: a,
                                b: b,
                                amplitude: amplitude,
                                smoothness: smoothness
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Parameter A slider
                VStack(alignment: .leading) {
                    Text("Parameter A: \(a, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $a, in: 1...10)
                }
                
                // Parameter B slider
                VStack(alignment: .leading) {
                    Text("Parameter B: \(b, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $b, in: 0.5...5)
                }
                
                // Amplitude slider
                VStack(alignment: .leading) {
                    Text("Amplitude: \(Int(amplitude))")
                        .font(.caption)
                    Slider(value: $amplitude, in: 20...200)
                }
                
                // Smoothness slider
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.05...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        a = 4
                        b = 1
                        amplitude = 120
                        smoothness = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Gentle") {
                        a = 3
                        b = 2
                        amplitude = 60
                        smoothness = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Wild") {
                        a = 8
                        b = 1
                        amplitude = 180
                        smoothness = 0.05
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
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
        .navigationTitle("CrazyParametricFun")
    }
}

#Preview {
    CrazyParametricFunView()
}
