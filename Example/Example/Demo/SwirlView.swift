import SwiftUI
import ViewIsComming

struct SwirlView: View {
    @State private var showFirstImage = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showFirstImage {
                    Image(.haNoi)
                        .resizable()
                        .transition(.swirl)
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(.swirl)
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
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
        .navigationTitle("Swirl")
    }
}

#Preview {
    SwirlView()
}
