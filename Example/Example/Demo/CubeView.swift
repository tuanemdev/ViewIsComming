import SwiftUI
import ViewIsComming

struct CubeView: View {
    @State private var showView = true
    // Controls
    @State private var perspective: Double = 0.7
    @State private var unzoom: Double = 0.3
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .cube(
                                perspective: perspective,
                                unzoom: unzoom
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
                    Text("Perspective: \(perspective, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $perspective, in: 0.1...2.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Unzoom: \(unzoom, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $unzoom, in: 0.0...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        perspective = 0.4
                        unzoom = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        perspective = 0.7
                        unzoom = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong") {
                        perspective = 1.2
                        unzoom = 0.5
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
        .navigationTitle("Cube")
    }
}

#Preview {
    CubeView()
}
