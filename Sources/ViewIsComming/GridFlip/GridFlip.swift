import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func gridFlip(
        size: CGSize = CGSize(width: 4, height: 4),
        pause: Double = 0.1,
        dividerWidth: Double = 0.05,
        randomness: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: GridFlipModifier(
                progress: 0,
                size: size,
                pause: pause,
                dividerWidth: dividerWidth,
                randomness: randomness
            ),
            identity: GridFlipModifier(
                progress: 1,
                size: size,
                pause: pause,
                dividerWidth: dividerWidth,
                randomness: randomness
            )
        )
    }
}

struct GridFlipModifier: ViewModifier {
    let progress: Double
    let size: CGSize
    let pause: Double
    let dividerWidth: Double
    let randomness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.gridFlip(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(size.width), Float(size.height)),
                            .float(pause),
                            .float(dividerWidth),
                            .float(randomness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == GridFlipTransition {
    static func gridFlip(
        size: CGSize = CGSize(width: 4, height: 4),
        pause: Double = 0.1,
        dividerWidth: Double = 0.05,
        randomness: Double = 0.1
    ) -> Self {
        GridFlipTransition(
            size: size,
            pause: pause,
            dividerWidth: dividerWidth,
            randomness: randomness
        )
    }
}

public struct GridFlipTransition: Transition {
    let size: CGSize
    let pause: Double
    let dividerWidth: Double
    let randomness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.gridFlip(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(size.width), Float(size.height)),
                            .float(pause),
                            .float(dividerWidth),
                            .float(randomness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
