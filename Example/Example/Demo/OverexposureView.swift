import SwiftUI
import ViewIsComming

struct OverexposureView: View {
    @State private var showView = true
    // Controls
    @State private var strength: Double = 2.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .overexposure(strength: strength)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Strength: \(strength, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $strength, in: 0.5...5.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        strength = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        strength = 2.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Intense") {
                        strength = 4.0
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
        .navigationTitle("Overexposure")
    }
}

#Preview {
    OverexposureView()
}
