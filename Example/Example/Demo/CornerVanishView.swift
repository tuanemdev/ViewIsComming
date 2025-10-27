import SwiftUI
import ViewIsComming

struct CornerVanishView: View {
    @State private var showView = true
    // Controls
    @State private var smoothness: Double = 0.3
    @State private var corner: Corner = .topLeft
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .cornerVanish(
                                smoothness: smoothness,
                                corner: corner
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
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
                
                VStack(spacing: 40) {
                    HStack(spacing: 40) {
                        // Top-Left
                        Button {
                            corner = .topLeft
                        } label: {
                            Image(systemName: "arrow.up.left.circle.fill")
                                .foregroundColor(corner == .topLeft ? .blue : .gray)
                        }
                        
                        // Top-Right
                        Button {
                            corner = .topRight
                        } label: {
                            Image(systemName: "arrow.up.right.circle.fill")
                                .foregroundColor(corner == .topRight ? .blue : .gray)
                        }
                    }
                    
                    HStack(spacing: 40) {
                        // Bottom-Left
                        Button {
                            corner = .bottomLeft
                        } label: {
                            Image(systemName: "arrow.down.left.circle.fill")
                                .foregroundColor(corner == .bottomLeft ? .blue : .gray)
                        }
                        
                        // Bottom-Right
                        Button {
                            corner = .bottomRight
                        } label: {
                            Image(systemName: "arrow.down.right.circle.fill")
                                .foregroundColor(corner == .bottomRight ? .blue : .gray)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
                .font(.title)
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
                    .transaction { $0.animation = nil }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("CornerVanish")
    }
}

#Preview {
    CornerVanishView()
}
