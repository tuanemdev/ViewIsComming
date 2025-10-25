import SwiftUI
import ViewIsComming

struct BounceView: View {
    @State private var showView = true
    // Controls
    @State private var bounces: Double = 4.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.bounce(bounces: bounces))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background {
                Image(.haLong)
                    .resizable()
            }
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Bounces: \(Int(bounces))")
                        .font(.caption)
                    Slider(value: $bounces, in: 1.0...10.0, step: 1.0)
                }
                
                HStack(spacing: 10) {
                    Button("Gentle") {
                        bounces = 2.0
                    }
                    
                    Button("Default") {
                        bounces = 4.0
                    }
                    
                    Button("Energetic") {
                        bounces = 8.0
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
            Button(action: {
                withAnimation(.linear(duration: 3.0)) {
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
        .navigationTitle("Bounce")
    }
}

#Preview {
    BounceView()
}
