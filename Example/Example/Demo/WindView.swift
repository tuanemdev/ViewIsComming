import SwiftUI
import ViewIsComming

struct WindView: View {
    @State private var showFirstImage = true
    @State private var windSize: Double = 0.2
    @State private var direction: WindDirection = .leftToRight
    
    var body: some View {
        ScrollView {
            ZStack {
                if showFirstImage {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .wind(windSize: windSize, direction: direction),
                                removal: .none
                            )
                        )
                } else {
                    Image(.haLong)
                        .resizable()
                        .transition(
                            .asymmetric(
                                insertion: .wind(windSize: windSize, direction: direction),
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
                    Text("Wind Size: \(windSize, specifier: "%.2f")")
                        .font(.caption)
                    Slider(value: $windSize, in: 0.0...0.5)
                }
                
                VStack(alignment: .leading) {
                    Text("Direction")
                        .font(.caption)
                    Picker("Direction", selection: $direction) {
                        Text("Left → Right").tag(WindDirection.leftToRight)
                        Text("Right → Left").tag(WindDirection.rightToLeft)
                        Text("Top → Bottom").tag(WindDirection.topToBottom)
                        Text("Bottom → Top").tag(WindDirection.bottomToTop)
                    }
                    .pickerStyle(.menu)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showFirstImage.toggle()
                }
            }) {
                Text("Switch Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Wind")
    }
}

#Preview {
    WindView()
}
