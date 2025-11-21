import SwiftUI
import ViewIsComming

struct PinWheelView: View {
    @State private var showView = true
    @State private var blades: Int = 8
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.asymmetric(insertion: .pinWheel(blades: blades), removal: .none))
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(.asymmetric(insertion: .pinWheel(blades: blades), removal: .none))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Blades: \(blades)")
                        .font(.caption)
                    Slider(value: Binding(
                        get: { Double(blades) },
                        set: { blades = Int($0) }
                    ), in: 3...16, step: 1)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
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
        .navigationTitle("PinWheel")
    }
}

#Preview {
    PinWheelView()
}
