import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func randomNoise(
        density: Double = 50.0
    ) -> AnyTransition {
        .modifier(
            active: RandomNoiseModifier(
                progress: 0,
                density: density
            ),
            identity: RandomNoiseModifier(
                progress: 1,
                density: density
            )
        )
    }
}

struct RandomNoiseModifier: ViewModifier {
    let progress: Double
    let density: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.randomNoise(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(density)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == RandomNoiseTransition {
    static func randomNoise(
        density: Double = 50.0
    ) -> Self {
        RandomNoiseTransition(density: density)
    }
}

public struct RandomNoiseTransition: Transition {
    let density: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.randomNoise(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(density)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
