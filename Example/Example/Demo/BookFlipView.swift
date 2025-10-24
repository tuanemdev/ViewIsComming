import SwiftUI
import ViewIsComming

struct BookFlipView: View {
    @State private var showView = false
    @State private var flipDirection: BookFlipDirection = .right
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    if showView {
                        Image(.haNoi)
                            .resizable()
                            .transition(.asymmetric(
                                insertion: .bookFlip(direction: flipDirection),
                                removal: .bookFlip(direction: flipDirection.opposite)
                            ))
                            .id("HaNoi-\(flipDirection)")
                    } else {
                        Image(.haLong)
                            .resizable()
                            .transition(.asymmetric(
                                insertion: .bookFlip(direction: flipDirection),
                                removal: .bookFlip(direction: flipDirection.opposite)
                            ))
                            .id("HaLong-\(flipDirection)")
                    }
                }
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 50)
                
                HStack(spacing: 20) {
                    // Flip Left Button
                    Button(action: {
                        flipDirection = .left
                        withAnimation(.linear(duration: 1.0)) {
                            showView.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Flip Left")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.cyan],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10)
                    }
                    
                    // Flip Right Button
                    Button(action: {
                        flipDirection = .right
                        withAnimation(.linear(duration: 1.0)) {
                            showView.toggle()
                        }
                    }) {
                        HStack {
                            Text("Flip Right")
                            Image(systemName: "arrow.right")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.orange, Color.red],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("BookFlip")
    }
}

#Preview {
    BookFlipView()
}
