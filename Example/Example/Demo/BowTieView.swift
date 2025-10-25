import SwiftUI
import ViewIsComming

struct BowTieView: View {
    @State private var showView = true
    @State private var orientation: BowTieOrientation = .horizontal
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.bowTie(orientation: orientation))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                Picker("Orientation", selection: $orientation) {
                    Text("Horizontal").tag(BowTieOrientation.horizontal)
                    Text("Vertical").tag(BowTieOrientation.vertical)
                }
                .pickerStyle(.segmented)
                
                Text("Creates a bow tie or hourglass pattern that reveals the content from the edges toward the center, then from the center toward the opposite edges.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showView.toggle()
                }
            }) {
                Text(showView ? "Hide" : "Show")
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
        .navigationTitle("BowTie")
    }
}

#Preview {
    BowTieView()
}
