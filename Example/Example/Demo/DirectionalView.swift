import SwiftUI
import ViewIsComming

struct DirectionalView: View {
    @State private var showFirstImage = true
    @State private var direction: DirectionalDirection = .right
    
    var body: some View {
        ScrollView {
            ZStack {
                if showFirstImage {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .directional(direction: direction),
                                removal: .directional(direction: direction.opposite)
                            )
                        )
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .directional(direction: direction),
                                removal: .directional(direction: direction.opposite)
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
                withAnimation(.linear(duration: 1.0)) {
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
        .navigationTitle("Directional")
    }
}

#Preview {
    DirectionalView()
}
