import SwiftUI
import ViewIsComming

struct CircleCropView: View {
    @State private var showHN = true
    @State private var isCurrentHN = true
    @State private var showHL = false
    @State private var smoothness: Double = 0.3
    
    var body: some View {
        ScrollView {
            ZStack {
                if showHN {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .circleCrop(
                                smoothness: smoothness
                            )
                        )
                }
                if showHL {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .circleCrop(
                                smoothness: smoothness
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Smoothness: \(smoothness, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $smoothness, in: 0.0...1.0)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    if isCurrentHN {
                        showHN.toggle()
                    } else {
                        showHL.toggle()
                    }
                } completion: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if isCurrentHN {
                            showHL.toggle()
                        } else {
                            showHN.toggle()
                        }
                        isCurrentHN.toggle()
                    }
                }
            }) {
                Text(isCurrentHN ? "Ha Noi" : "Ha Long")
                    .transaction { $0.animation = nil }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("CircleCrop")
    }
}

#Preview {
    CircleCropView()
}
