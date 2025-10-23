import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func scaleIn(
        scale: Double = 0.0
    ) -> AnyTransition {
        .modifier(
            active: ScaleInModifier(
                progress: 0,
                scale: scale
            ),
            identity: ScaleInModifier(
                progress: 1,
                scale: scale
            )
        )
    }
}

struct ScaleInModifier: ViewModifier {
    let progress: Double
    let scale: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.scaleIn(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(scale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == ScaleInTransition {
    static func scaleIn(
        scale: Double = 0.0
    ) -> Self {
        ScaleInTransition(scale: scale)
    }
}

public struct ScaleInTransition: Transition {
    let scale: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.scaleIn(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(scale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
