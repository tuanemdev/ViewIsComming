import SwiftUI
import ViewIsComming

struct TVStaticView: View {
    @State private var showView = true
    @State private var offset: Double = 0.05
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .tvStatic(offset: offset)
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Static Offset: \(offset, specifier: "%.3f")")
                        .font(.caption)
                    Slider(value: $offset, in: 0.0...0.2)
                }
                
                Text("The offset controls how long the fade in/out lasts before showing static noise.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 10) {
                    Button("Quick") {
                        offset = 0.02
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        offset = 0.05
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Slow") {
                        offset = 0.15
                    }
                    .buttonStyle(.bordered)
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
        .navigationTitle("TVStatic")
    }
}

#Preview {
    TVStaticView()
}
