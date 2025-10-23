import SwiftUI
import ViewIsComming

struct SimpleBookCurlView: View {
    @State private var showView = true
    // Controls
    @State private var curlAmount: Double = 0.5
    @State private var radius: Double = 0.2
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .simpleBookCurl(
                                curlAmount: curlAmount,
                                radius: radius
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
                    Text("Curl Amount: \(curlAmount, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $curlAmount, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Radius: \(radius, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $radius, in: 0.05...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Soft") {
                        curlAmount = 0.3
                        radius = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        curlAmount = 0.5
                        radius = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Sharp") {
                        curlAmount = 0.8
                        radius = 0.1
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
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
        .navigationTitle("SimpleBookCurl")
    }
}

#Preview {
    SimpleBookCurlView()
}
