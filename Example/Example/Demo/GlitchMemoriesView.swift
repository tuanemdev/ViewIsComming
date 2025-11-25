import SwiftUI
import ViewIsComming

struct GlitchMemoriesView: View {
    @State private var showView = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.glitchMemories)
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Single Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 2.0)) {
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
        .navigationTitle("GlitchMemories")
    }
}

#Preview {
    GlitchMemoriesView()
}
