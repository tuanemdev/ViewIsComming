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
                        .transition(.windowSlice(count: count, smoothness: smoothness))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Count slider
                VStack(alignment: .leading) {
                    Text("Count: \(Int(count))")
                    Slider(value: $count, in: 2...30, step: 1)
                }
                
                // Smoothness slider
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
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
        .navigationTitle("WindowSlice")
    }
}

#Preview {
    WindowSliceView()
}
