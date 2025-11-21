import SwiftUI
import ViewIsComming

struct DirectionalWipeView: View {
    @State private var showFirstImage = true
    @State private var direction: DirectionalWipeDirection = .right
    @State private var smoothness: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showFirstImage {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .directionalWipe(direction: direction.opposite, smoothness: smoothness),
                                removal: .none
                            )
                        )
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .directionalWipe(direction: direction.opposite, smoothness: smoothness),
                                removal: .none
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
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
                
                VStack(spacing: 10) {
                    // Top
                    Button {
                        direction = .up
                    } label: {
                        Image(systemName: "arrowshape.up.circle")
                    }
                    
                    HStack(spacing: 40) {
                        // Left
                        Button {
                            direction = .left
                        } label: {
                            Image(systemName: "arrowshape.left.circle")
                        }
                        
                        // Right
                        Button {
                            direction = .right
                        } label: {
                            Image(systemName: "arrowshape.right.circle")
                        }
                    }
                    
                    // Bottom
                    Button {
                        direction = .down
                    } label: {
                        Image(systemName: "arrowshape.down.circle")
                    }
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.bordered)
                .font(.title2)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
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
        .navigationTitle("DirectionalWipe")
    }
}

#Preview {
    DirectionalWipeView()
}
