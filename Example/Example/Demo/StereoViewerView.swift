import SwiftUI
import ViewIsComming

struct StereoViewerView: View {
    @State private var showView = true
    // Controls
    @State private var zoom: Double = 0.88
    @State private var cornerRadius: Double = 0.22
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.stereoViewer(zoom: zoom, cornerRadius: cornerRadius))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Zoom: \(zoom, specifier: "%.2f")")
                    Slider(value: $zoom, in: 0.5...1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Corner Radius: \(cornerRadius, specifier: "%.2f")")
                    Slider(value: $cornerRadius, in: 0.0...0.5)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
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
        .navigationTitle("StereoViewer")
    }
}

#Preview {
    StereoViewerView()
}
