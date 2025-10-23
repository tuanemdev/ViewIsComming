import SwiftUI
import ViewIsComming

struct WindView: View {
    @State private var showView = true
    @State private var windSize: Double = 0.2
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.wind(size: windSize))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Wind Size: \(windSize, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $windSize, in: 0.0...0.5)
                }
                
                Text("Horizontal wind effect with random displacement")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 10) {
                    Button("Gentle (0.1)") {
                        windSize = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default (0.2)") {
                        windSize = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong (0.4)") {
                        windSize = 0.4
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
        .navigationTitle("Wind")
    }
}

#Preview {
    WindView()
}
