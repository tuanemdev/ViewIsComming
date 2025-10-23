import SwiftUI
import ViewIsComming

struct RadialBlurView: View {
    @State private var showView = true
    // Controls
    @State private var samples: Double = 10.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .radialBlur(samples: samples)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Samples: \(Int(samples))")
                        .font(.caption)
                    Slider(value: $samples, in: 5.0...20.0, step: 1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Low Quality") {
                        samples = 5.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        samples = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("High Quality") {
                        samples = 15.0
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
        .navigationTitle("RadialBlur")
    }
}

#Preview {
    RadialBlurView()
}
