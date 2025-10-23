import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func spiral(
        rotations: Double = 3.0
    ) -> AnyTransition {
        .modifier(
            active: SpiralModifier(
                progress: 0,
                rotations: rotations
            ),
            identity: SpiralModifier(
                progress: 1,
                rotations: rotations
            )
        )
    }
}

struct SpiralModifier: ViewModifier {
    let progress: Double
    let rotations: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.spiral(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(rotations)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == SpiralTransition {
    static func spiral(
        rotations: Double = 3.0
    ) -> Self {
        SpiralTransition(rotations: rotations)
    }
}

public struct SpiralTransition: Transition {
    let rotations: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.spiral(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(rotations)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
