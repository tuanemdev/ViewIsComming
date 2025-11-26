import SwiftUI
import ViewIsComming

struct InvertedPageCurlView: View {
    @State private var showView = true
    // Controls
    @State private var direction: InvertedPageCurlDirection = .rightToLeft
    @State private var edge: InvertedPageCurlEdge = .top
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.invertedPageCurl(direction: direction, edge: edge))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
            // Controls
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Direction")
                        .font(.caption)
                    Picker("Direction", selection: $direction) {
                        Text("Right to Left").tag(InvertedPageCurlDirection.rightToLeft)
                        Text("Left to Right").tag(InvertedPageCurlDirection.leftToRight)
                    }
                }
                VStack(alignment: .leading) {
                    Text("Edge")
                        .font(.caption)
                    Picker("Edge", selection: $edge) {
                        Text("Top").tag(InvertedPageCurlEdge.top)
                        Text("Bottom").tag(InvertedPageCurlEdge.bottom)
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Trigger Button
            Button(action: {
                withAnimation(.easeInOut(duration: 2.0)) {
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
        .navigationTitle("InvertedPageCurl")
    }
}

#Preview {
    InvertedPageCurlView()
}
