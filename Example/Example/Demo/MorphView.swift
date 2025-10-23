import SwiftUI
import ViewIsComming

struct MorphView: View {
    @State private var showView = true
    @State private var strength: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .morph(strength: strength)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Strength: \(strength, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $strength, in: 0.0...0.5)
                }
                
                HStack(spacing: 10) {
                    Button("Subtle") {
                        strength = 0.05
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        strength = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong") {
                        strength = 0.3
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
        .navigationTitle("Morph")
    }
}

#Preview {
    MorphView()
}
