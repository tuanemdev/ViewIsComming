import SwiftUI
import ViewIsComming

struct LumaView: View {
    @State private var showView = true
    @State private var patternScale: Double = 3.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .luma(patternScale: patternScale)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Pattern Scale: \(patternScale, specifier: "%.1f")")
                    .font(.caption)
                Slider(value: $patternScale, in: 1.0...10.0)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
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
        .navigationTitle("Luma")
    }
}

#Preview {
    LumaView()
}
