import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func crossZoom(
        strength: Double = 0.4
    ) -> AnyTransition {
        .modifier(
            active: CrossZoomModifier(
                progress: 0,
                strength: strength
            ),
            identity: CrossZoomModifier(
                progress: 1,
                strength: strength
            )
        )
    }
}

struct CrossZoomModifier: ViewModifier {
    let progress: Double
    let strength: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.crossZoom(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(strength)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == CrossZoomTransition {
    static func crossZoom(
        strength: Double = 0.4
    ) -> Self {
        CrossZoomTransition(strength: strength)
    }
}

public struct CrossZoomTransition: Transition {
    let strength: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.crossZoom(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(strength)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
