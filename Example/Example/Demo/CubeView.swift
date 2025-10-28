import SwiftUI
import ViewIsComming

struct CubeView: View {
    @State private var showView = true
    // Controls
    @State private var perspective: Double = 0.7
    @State private var unzoom: Double = 0.3
    @State private var rotateRight: Bool = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .cube(
                                    perspective: perspective,
                                    unzoom: unzoom,
                                    rotateRight: rotateRight
                                ),
                                removal: .cube(
                                    perspective: perspective,
                                    unzoom: unzoom,
                                    rotateRight: !rotateRight
                                )
                            )
                        )
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .cube(
                                    perspective: perspective,
                                    unzoom: unzoom,
                                    rotateRight: rotateRight
                                ),
                                removal: .cube(
                                    perspective: perspective,
                                    unzoom: unzoom,
                                    rotateRight: !rotateRight
                                )
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Perspective: \(perspective, specifier: "%.1f")")
                    Slider(value: $perspective, in: 0.1...2.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Unzoom: \(unzoom, specifier: "%.1f")")
                    Slider(value: $unzoom, in: 0.0...1.0)
                }
                
                Toggle("Rotate Right", isOn: $rotateRight)
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
        .navigationTitle("Cube")
    }
}

#Preview {
    CubeView()
}
