import SwiftUI
import ViewIsComming

struct CircleCropView: View {
    @State private var showView = true
    @State private var selectedColor = 0
    
    let colorOptions: [(name: String, color: Color)] = [
        ("Black", .black),
        ("White", .white),
        ("Blue", .blue),
        ("Gray", .gray)
    ]
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.circleCrop(backgroundColor: colorOptions[selectedColor].color))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Background Color")
                        .font(.caption)
                    Picker("Color", selection: $selectedColor) {
                        ForEach(0..<colorOptions.count, id: \.self) { index in
                            HStack {
                                Circle()
                                    .fill(colorOptions[index].color)
                                    .frame(width: 12, height: 12)
                                Text(colorOptions[index].name)
                            }
                            .tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Text("Circular reveal/hide transition")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("Content appears/disappears in a circular pattern from center")
                    .font(.caption)
                    .foregroundStyle(.secondary)
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
        .navigationTitle("Circle Crop")
    }
}

#Preview {
    CircleCropView()
}
