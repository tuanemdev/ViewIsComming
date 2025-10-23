import SwiftUI
import ViewIsComming

struct SqueezeView: View {
    @State private var showView = true
    @State private var colorSeparation: Double = 0.04
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .squeeze(colorSeparation: colorSeparation)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Color Separation: \(colorSeparation, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $colorSeparation, in: 0.0...0.15)
                }
                
                HStack(spacing: 10) {
                    Button("None") {
                        colorSeparation = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        colorSeparation = 0.04
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong") {
                        colorSeparation = 0.1
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
        .navigationTitle("Squeeze")
    }
}

#Preview {
    SqueezeView()
}
