import SwiftUI
import ViewIsComming

struct MosaicView: View {
    @State private var showView = true
    @State private var endX: Double = 10.0
    @State private var endY: Double = 10.0
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .mosaic(
                                endX: Int(endX),
                                endY: Int(endY)
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Horizontal Tiles: \(Int(endX))")
                        .font(.caption)
                    Slider(value: $endX, in: 2.0...30.0, step: 1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Vertical Tiles: \(Int(endY))")
                        .font(.caption)
                    Slider(value: $endY, in: 2.0...30.0, step: 1.0)
                }
                
                HStack(spacing: 10) {
                    Button("Coarse") {
                        endX = 5.0
                        endY = 5.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default") {
                        endX = 10.0
                        endY = 10.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Fine") {
                        endX = 20.0
                        endY = 20.0
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
        .navigationTitle("Mosaic")
    }
}

#Preview {
    MosaicView()
}
