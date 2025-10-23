import SwiftUI
import ViewIsComming

struct WindowBlindsView: View {
    @State private var showView = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.windowBlinds)
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Info
            VStack(alignment: .leading, spacing: 15) {
                Text("Window Blinds Transition")
                    .font(.headline)
                
                Text("This transition simulates window blinds opening or closing. No adjustable parameters.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
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
        .navigationTitle("WindowBlinds")
    }
}

#Preview {
    WindowBlindsView()
}
