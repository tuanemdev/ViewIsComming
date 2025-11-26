import SwiftUI
import ViewIsComming

struct PolkaDotsCurtainView: View {
    @State private var showHaNoi = true
    @State private var dots: Double = 20.0
    @State private var selectedCenter: CenterPreset = .center
    @State private var customX: Double = 0.5
    @State private var customY: Double = 0.5
    
    enum CenterPreset: String, CaseIterable {
        case topLeft = "Top Left"
        case topRight = "Top Right"
        case bottomLeft = "Bottom Left"
        case bottomRight = "Bottom Right"
        case center = "Center"
        case custom = "Custom"
        
        var polkaDotCenter: PolkaDotsCurtainCenter {
            switch self {
            case .topLeft: return .topLeft
            case .topRight: return .topRight
            case .bottomLeft: return .bottomLeft
            case .bottomRight: return .bottomRight
            case .center: return .center
            case .custom: return .center // Will be overridden
            }
        }
    }
    
    var centerPosition: PolkaDotsCurtainCenter {
        if selectedCenter == .custom {
            return .custom(x: customX, y: customY)
        } else {
            return selectedCenter.polkaDotCenter
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                if showHaNoi {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .polkaDotsCurtain(dots: dots, center: centerPosition),
                                removal: .none
                            )
                        )
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .polkaDotsCurtain(dots: dots, center: centerPosition),
                                removal: .none
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Dots: \(Int(dots))")
                    Slider(value: $dots, in: 5.0...50.0, step: 1.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Center Position")
                    Picker("Center", selection: $selectedCenter) {
                        ForEach(CenterPreset.allCases, id: \.self) { preset in
                            Text(preset.rawValue).tag(preset)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                if selectedCenter == .custom {
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading) {
                            Text("Custom X: \(customX, specifier: "%.2f")")
                            Slider(value: $customX, in: 0.0...1.0)
                        }
                        VStack(alignment: .leading) {
                            Text("Custom Y: \(customY, specifier: "%.2f")")
                            Slider(value: $customY, in: 0.0...1.0)
                        }
                    }
                    .padding(.top, 5)
                }
            }
            .font(.caption)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showHaNoi.toggle()
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
        .navigationTitle("PolkaDotsCurtain")
    }
}

#Preview {
    PolkaDotsCurtainView()
}
