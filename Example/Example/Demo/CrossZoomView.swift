import SwiftUI
import ViewIsComming

struct CrossZoomView: View {
    @State private var showView = true
    @State private var strength: Double = 0.4
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .crossZoom(strength: strength)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Strength: \(strength, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $strength, in: 0.0...1.0)
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
                Text(showView ? "Hide" : "Show")
                    .transaction { $0.animation = nil }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("CrossZoom")
    }
}

#Preview {
    CrossZoomView()
}
