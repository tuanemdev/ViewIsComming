import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func rotate(
        angle: Double = .pi * 2
    ) -> AnyTransition {
        .modifier(
            active: RotateModifier(
                progress: 0,
                angle: angle
            ),
            identity: RotateModifier(
                progress: 1,
                angle: angle
            )
        )
    }
}

struct RotateModifier: ViewModifier {
    let progress: Double
    let angle: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.rotate(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(angle)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == RotateTransitionEffect {
    static func rotate(
        angle: Double = .pi * 2
    ) -> Self {
        RotateTransitionEffect(angle: angle)
    }
}

public struct RotateTransitionEffect: Transition {
    let angle: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.rotate(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(angle)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
