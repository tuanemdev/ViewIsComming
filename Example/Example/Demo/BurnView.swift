import SwiftUI
import ViewIsComming

struct BurnView: View {
    @State private var showView = true
    @State private var selectedColor = 0
    
    let colorOptions: [(name: String, color: Color)] = [
        ("Fire (Orange)", Color(red: 0.9, green: 0.4, blue: 0.2)),
        ("Blue Flame", Color(red: 0.2, green: 0.4, blue: 0.9)),
        ("Green Glow", Color(red: 0.2, green: 0.9, blue: 0.4)),
        ("Purple Magic", Color(red: 0.7, green: 0.2, blue: 0.9))
    ]
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.burn(color: colorOptions[selectedColor].color))
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(.burn(color: colorOptions[selectedColor].color))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Burn Color")
                            .font(.caption)
                        
                        Circle()
                            .fill(colorOptions[selectedColor].color)
                            .frame(width: 12, height: 12)
                    }
                    
                    Picker("Color", selection: $selectedColor) {
                        ForEach(0..<colorOptions.count, id: \.self) { index in
                            Text(colorOptions[index].name)
                                .tag(index)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Text("Transition with a burning/glowing color effect. The appearing image starts with bright burn color that fades to normal as it becomes fully visible.")
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
        .navigationTitle("Burn")
    }
}

#Preview {
    BurnView()
}
