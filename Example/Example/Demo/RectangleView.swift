import SwiftUI
import ViewIsComming

struct RectangleView: View {
    @State private var showView = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.rectangle)
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Info
            VStack(alignment: .leading, spacing: 15) {
                Text("Rectangle Crop Transition")
                    .font(.headline)
                
                Text("The view shrinks into a rectangle from all corners, reaching the smallest size at the midpoint, then expands back to full size.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
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
        .navigationTitle("Rectangle")
    }
}

#Preview {
    RectangleView()
}
