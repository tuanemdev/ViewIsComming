import SwiftUI
import ViewIsComming

struct PinWheelView: View {
    @State private var showView = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.asymmetric(insertion: .pinWheel(), removal: .none))
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(.asymmetric(insertion: .pinWheel(), removal: .none))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Trigger Button
            VStack(spacing: 15) {
                Button("Toggle Views") {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        showView.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                // Different speeds
                HStack(spacing: 10) {
                    Button("Slow (speed: 1.0)") {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            showView.toggle()
                        }
                    }
                    
                    Button("Fast (speed: 4.0)") {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            showView.toggle()
                        }
                    }
                }
                .buttonStyle(.bordered)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("PinWheel")
    }
}

#Preview {
    PinWheelView()
}
