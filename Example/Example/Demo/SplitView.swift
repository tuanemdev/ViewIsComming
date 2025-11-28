import SwiftUI
import ViewIsComming

struct SplitView: View {
    @State private var showView = true
    // Controls
    @State private var axis: SplitAxis = .horizontal
    @State private var direction: SplitDirection = .open
    @State private var smoothness: Double = 0.1
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.split(axis: axis, direction: direction, smoothness: smoothness))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                // Axis Picker
                VStack(alignment: .leading) {
                    Text("Axis")
                        .font(.caption)
                    Picker("Axis", selection: $axis) {
                        Text("Horizontal").tag(SplitAxis.horizontal)
                        Text("Vertical").tag(SplitAxis.vertical)
                    }
                    .pickerStyle(.segmented)
                }
                
                // Direction Picker
                VStack(alignment: .leading) {
                    Text("Direction")
                        .font(.caption)
                    Picker("Direction", selection: $direction) {
                        Text("Open").tag(SplitDirection.open)
                        Text("Close").tag(SplitDirection.close)
                    }
                    .pickerStyle(.segmented)
                }
                
                // Smoothness Slider
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.01...0.5)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button
            Button(action: {
                withAnimation(.easeOut(duration: 1.0)) {
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
        .navigationTitle("Split")
    }
}

#Preview {
    SplitView()
}
