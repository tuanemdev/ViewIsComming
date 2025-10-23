import SwiftUI
import ViewIsComming

struct FoldView: View {
    @State private var showView = true
    // Controls
    @State private var folds: Double = 3.0
    @State private var intensity: Double = 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .fold(
                                folds: folds,
                                intensity: intensity
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Folds: \(Int(folds))")
                        .font(.caption)
                    Slider(value: $folds, in: 1...10, step: 1)
                }
                
                VStack(alignment: .leading) {
                    Text("Intensity: \(intensity, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $intensity, in: 0.1...1.0)
                }
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Gentle") {
                        folds = 2.0
                        intensity = 0.3
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        folds = 3.0
                        intensity = 0.5
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Intense") {
                        folds = 6.0
                        intensity = 0.8
                    }
                    .buttonStyle(.bordered)
                }
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
        .navigationTitle("Fold")
    }
}

#Preview {
    FoldView()
}
