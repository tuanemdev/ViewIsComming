import SwiftUI
import ViewIsComming

struct CircleOpenView: View {
    @State private var showView = true
    @State private var smoothness: Double = 0.3
    @State private var opening: Bool = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .circleOpen(
                                smoothness: smoothness,
                                opening: opening
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
                
                Toggle("Opening (vs Closing)", isOn: $opening)
                    .font(.caption)
                
                HStack(spacing: 10) {
                    Button("Sharp") {
                        smoothness = 0.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        smoothness = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Soft") {
                        smoothness = 0.8
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
        .navigationTitle("CircleOpen")
    }
}

#Preview {
    CircleOpenView()
}
