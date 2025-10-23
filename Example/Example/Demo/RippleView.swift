import SwiftUI
import ViewIsComming

struct RippleView: View {
    @State private var showView = true
    @State private var amplitude: Double = 100.0
    @State private var speed: Double = 50.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.ripple(amplitude: amplitude, speed: speed))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Amplitude: \(Int(amplitude))")
                        .font(.caption)
                    Slider(value: $amplitude, in: 10...200)
                }
                
                VStack(alignment: .leading) {
                    Text("Speed: \(Int(speed))")
                        .font(.caption)
                    Slider(value: $speed, in: 10...100)
                }
                
                Text("Water ripple distortion effect emanating from center")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 10) {
                    Button("Gentle") {
                        amplitude = 50
                        speed = 30
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        amplitude = 100
                        speed = 50
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Intense") {
                        amplitude = 150
                        speed = 80
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
        .navigationTitle("Ripple")
    }
}

#Preview {
    RippleView()
}
