import SwiftUI
import ViewIsComming

struct WipeView: View {
    @State private var showView = true
    @State private var selectedDirection = 0
    
    let directions = ["Up", "Down", "Left", "Right"]
    
    var selectedTransition: AnyTransition {
        switch selectedDirection {
        case 0: return .wipeUp
        case 1: return .wipeDown
        case 2: return .wipeLeft
        case 3: return .wipeRight
        default: return .wipeUp
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(selectedTransition)
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Direction")
                        .font(.caption)
                    Picker("Direction", selection: $selectedDirection) {
                        ForEach(0..<directions.count, id: \.self) { index in
                            Text(directions[index]).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Text("Simple directional wipe transitions")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("Wipes reveal or hide the view from one edge to another")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
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
        .navigationTitle("Wipe Transitions")
    }
}

#Preview {
    WipeView()
}
