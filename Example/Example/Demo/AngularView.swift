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
                                startingAngle: .degrees(startingAngle),
                                clockwise: clockwise
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                Toggle("Clockwise", isOn: $clockwise)
                    .font(.caption)
                
                // Preset buttons in 4 directions
                VStack(spacing: 10) {
                    // Top
                    Button {
                        startingAngle = 90
                    } label: {
                        Image(systemName: "arrowshape.up.circle")
                    }
                    
                    HStack(spacing: 40) {
                        // Left
                        Button {
                            startingAngle = 180
                        } label: {
                            Image(systemName: "arrowshape.left.circle")
                        }
                        
                        // Right
                        Button {
                            startingAngle = 0
                        } label: {
                            Image(systemName: "arrowshape.right.circle")
                        }
                    }
                    
                    // Bottom
                    Button {
                        startingAngle = 270
                    } label: {
                        Image(systemName: "arrowshape.down.circle")
                    }
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.bordered)
                .font(.title2)
                
                // Slider
                VStack(alignment: .leading) {
                    Text("Starting Angle: \(Int(startingAngle))°")
                        .font(.caption)
                    Slider(value: $startingAngle, in: 0...360)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showView.toggle()
                }
            }) {
                Text(showView ? "Hide" : "Show")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
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
