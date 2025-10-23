import SwiftUI
import ViewIsComming

struct ColourDistanceView: View {
    @State private var showView = true
    
    // Controls
    @State private var power: Double = 5.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .colourDistance(power: power)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Power: \(power, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $power, in: 1.0...10.0)
                }
                
                Text("Controls the non-linearity of the fade. Higher values create a sharper cutoff between visible and invisible areas based on color distance.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Linear (1.0)") {
                        power = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Medium (5.0)") {
                        power = 5.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Sharp (10.0)") {
                        power = 10.0
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
        .navigationTitle("ColourDistance")
    }
}

#Preview {
    ColourDistanceView()
}
