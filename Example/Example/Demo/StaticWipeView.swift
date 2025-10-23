import SwiftUI
import ViewIsComming

struct StaticWipeView: View {
    @State private var showView = true
    // Controls
    @State private var upToDown: Bool = true
    @State private var maximumStatic: Double = 0.5
    @State private var staticFade: Double = 0.15
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .staticWipe(
                                upToDown: upToDown,
                                maximumStatic: maximumStatic,
                                staticFade: staticFade
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                Toggle("Up to Down", isOn: $upToDown)
                    .font(.caption)
                
                VStack(alignment: .leading) {
                    Text("Maximum Static: \(maximumStatic, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $maximumStatic, in: 0.0...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Static Fade: \(staticFade, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $staticFade, in: 0.01...0.5)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Subtle") {
                        maximumStatic = 0.2
                        staticFade = 0.1
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        maximumStatic = 0.5
                        staticFade = 0.15
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Heavy") {
                        maximumStatic = 0.8
                        staticFade = 0.3
                    }
                    .buttonStyle(.bordered)
                }
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
        .navigationTitle("StaticWipe")
    }
}

#Preview {
    StaticWipeView()
}
