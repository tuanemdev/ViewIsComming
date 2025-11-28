import SwiftUI
import ViewIsComming

struct UndulatingBurnOutView: View {
    @State private var showFirstImage: Bool = true
    // Controls
    @State private var smoothness: Double = 0.03
    @State private var centerX: Double = 0.5
    @State private var centerY: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showFirstImage {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .undulatingBurnOut(
                                    smoothness: smoothness,
                                    center: CGPoint(x: centerX, y: centerY)
                                ),
                                removal: .none
                            )
                        )
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .undulatingBurnOut(
                                    smoothness: smoothness,
                                    center: CGPoint(x: centerX, y: centerY)
                                ),
                                removal: .none
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
                    Text("Smoothness: \(smoothness, specifier: "%.3f")")
                    Slider(value: $smoothness, in: 0.001...0.2)
                }
                
                VStack(alignment: .leading) {
                    Text("Center X: \(centerX, specifier: "%.2f")")
                    Slider(value: $centerX, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Center Y: \(centerY, specifier: "%.2f")")
                    Slider(value: $centerY, in: 0.0...1.0)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
            Button(action: {
                withAnimation(.linear(duration: 2.5)) {
                    showFirstImage.toggle()
                }
            }) {
                Text("Switch Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("UndulatingBurnOut")
    }
}

#Preview {
    UndulatingBurnOutView()
}
