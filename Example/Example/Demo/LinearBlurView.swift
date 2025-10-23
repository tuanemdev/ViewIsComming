import SwiftUI
import ViewIsComming

struct LinearBlurView: View {
    @State private var showView = true
    @State private var intensity: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .linearBlur(intensity: intensity)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Intensity: \(intensity, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $intensity, in: 0.0...0.3)
                }
                
                HStack(spacing: 10) {
                    Button("Subtle") {
                        intensity = 0.05
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        intensity = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong") {
                        intensity = 0.2
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
        .navigationTitle("LinearBlur")
    }
}

#Preview {
    LinearBlurView()
}
