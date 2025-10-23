import SwiftUI
import ViewIsComming

struct RadialView: View {
    @State private var showView = true
    @State private var smoothness: Double = 1.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.radial(smoothness: smoothness))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.1...5.0)
                }
                
                Text("Radial wipe transition based on angle from center")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 10) {
                    Button("Sharp (0.2)") {
                        smoothness = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default (1.0)") {
                        smoothness = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Smooth (3.0)") {
                        smoothness = 3.0
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
        .navigationTitle("Radial")
    }
}

#Preview {
    RadialView()
}
