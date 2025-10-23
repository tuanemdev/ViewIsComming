import SwiftUI
import ViewIsComming

struct HorizontalOpenView: View {
    @State private var showView = true
    // Controls
    @State private var smoothness: Double = 0.1
    @State private var opening: Double = 1.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .horizontalOpen(
                                smoothness: smoothness,
                                opening: opening
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
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.01...0.5)
                }
                
                VStack(alignment: .leading) {
                    Text("Opening: \(opening, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $opening, in: 0.1...2.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Sharp") {
                        smoothness = 0.01
                        opening = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        smoothness = 0.1
                        opening = 1.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Wide") {
                        smoothness = 0.3
                        opening = 1.5
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
        .navigationTitle("HorizontalOpen")
    }
}

#Preview {
    HorizontalOpenView()
}
