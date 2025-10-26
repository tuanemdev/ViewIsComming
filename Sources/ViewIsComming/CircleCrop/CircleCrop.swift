import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func circleCrop(
        smoothness: Double = 0.3
    ) -> AnyTransition {
        .modifier(
            active: CircleCropModifier(
                progress: 0,
                smoothness: smoothness
            ),
            identity: CircleCropModifier(
                progress: 1,
                smoothness: smoothness
            )
        )
    }
}

struct CircleCropModifier: ViewModifier {
    let progress: Double
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.circleCrop(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == CircleCropTransition {
    static func circleCrop(
        smoothness: Double = 0.3
    ) -> Self {
        CircleCropTransition(
            smoothness: smoothness
        )
    }
}

public struct CircleCropTransition: Transition {
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.circleCrop(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
