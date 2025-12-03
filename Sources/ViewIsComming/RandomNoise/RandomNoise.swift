import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static var randomNoise: AnyTransition {
        .modifier(
            active: RandomNoiseModifier(progress: 0),
            identity: RandomNoiseModifier(progress: 1)
        )
    }
}

struct RandomNoiseModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.randomNoise(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == RandomNoiseTransition {
    static var randomNoise: Self {
        RandomNoiseTransition()
    }
}

public struct RandomNoiseTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.randomNoise(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
