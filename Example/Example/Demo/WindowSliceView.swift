import SwiftUI
import ViewIsComming

struct WindowSliceView: View {
    @State private var showView = true
    // Controls
    @State private var count: Double = 10.0
    @State private var smoothness: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .windowSlice(
                                count: count,
                                smoothness: smoothness
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Count slider
                VStack(alignment: .leading) {
                    Text("Count: \(Int(count))")
                        .font(.caption)
                    Slider(value: $count, in: 2...30, step: 1)
                }
                
                // Smoothness slider
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Default") {
                        count = 10.0
                        smoothness = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Many Slices") {
                        count = 25.0
                        smoothness = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Few Slices") {
                        count = 5.0
                        smoothness = 0.8
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
        .navigationTitle("WindowSlice")
    }
}

#Preview {
    WindowSliceView()
}
