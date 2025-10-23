import SwiftUI
import ViewIsComming

struct ScaleInView: View {
    @State private var showView = true
    // Controls
    @State private var scale: Double = 0.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .scaleIn(scale: scale)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Start Scale: \(scale, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $scale, in: 0.0...2.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("From Zero") {
                        scale = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("From Half") {
                        scale = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("From 1.5x") {
                        scale = 1.5
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
        .navigationTitle("ScaleIn")
    }
}

#Preview {
    ScaleInView()
}
