import SwiftUI
import ViewIsComming

struct DoorwayView: View {
    @State private var showHaNoi = true
    // Controls
    @State private var reflection: Double = 0.4
    @State private var perspective: Double = 0.4
    @State private var depth: Double = 3.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showHaNoi {
                    Image(.haLong)
                        .resizable()
                        .transition(.doorway(reflection: reflection, perspective: perspective, depth: depth))
                } else {
                    Image(.haNoi)
                        .resizable()
                        .transition(.doorway(reflection: reflection, perspective: perspective, depth: depth))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Reflection: \(reflection, specifier: "%.1f") (insertion water effect)")
                    Slider(value: $reflection, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Perspective: \(perspective, specifier: "%.1f") (removal split)")
                    Slider(value: $perspective, in: 0.1...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Depth: \(depth, specifier: "%.1f") (insertion zoom)")
                    Slider(value: $depth, in: 1.0...10.0)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showHaNoi.toggle()
                }
            }) {
                Text(showHaNoi ? "Show Hà Nội" : "Show Hạ Long")
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
        .navigationTitle("Doorway")
    }
}

#Preview {
    DoorwayView()
}
