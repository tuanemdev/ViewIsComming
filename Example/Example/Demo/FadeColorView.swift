import SwiftUI
import ViewIsComming

struct FadeColorView: View {
    @State private var showView = true
    @State private var colorPhase: Double = 0.4
    @State private var selectedColor = 0
    
    let colorOptions: [(name: String, color: Color)] = [
        ("Black", .black),
        ("White", .white),
        ("Red", .red),
        ("Blue", .blue),
        ("Green", .green),
        ("Purple", .purple)
    ]
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(.fadeColor(
                            color: colorOptions[selectedColor].color,
                            colorPhase: colorPhase
                        ))
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Color Phase: \(colorPhase, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $colorPhase, in: 0.0...0.9)
                }
                
                VStack(alignment: .leading) {
                    Text("Intermediate Color")
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
                    .pickerStyle(.menu)
                }
                
                Text("Fade through an intermediate color")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("Color phase: 0.0 = no color phase, 0.9 = prominent color phase")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 10) {
                    Button("Subtle (0.2)") {
                        colorPhase = 0.2
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Default (0.4)") {
                        colorPhase = 0.4
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Strong (0.7)") {
                        colorPhase = 0.7
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
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
        .navigationTitle("Fade Color")
    }
}

#Preview {
    FadeColorView()
}
