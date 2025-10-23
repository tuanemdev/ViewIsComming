import SwiftUI
import ViewIsComming

struct AngularView: View {
    @State private var showView = true
    // Controls
    @State private var startingAngle: Double = 90
    @State private var clockwise: Bool = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .angular(
                                startingAngle: startingAngle,
                                clockwise: clockwise
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
                    Text("Starting Angle: \(Int(startingAngle))°")
                        .font(.caption)
                    Slider(value: $startingAngle, in: 0...360, step: 15)
                }
                
                // Direction toggle
                Toggle("Clockwise", isOn: $clockwise)
                    .font(.caption)
                
                // Preset buttons
                HStack(spacing: 10) {
                    Button("Top (90°)") {
                        startingAngle = 90
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Right (0°)") {
                        startingAngle = 0
                    }
                    .buttonStyle(.bordered)
                }
                
                HStack(spacing: 10) {
                    Button("Bottom (270°)") {
                        startingAngle = 270
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Left (180°)") {
                        startingAngle = 180
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
        .navigationTitle("Angular")
    }
}

#Preview {
    AngularView()
}
