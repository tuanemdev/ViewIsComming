import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func verticalOpen(
        smoothness: Double = 0.1,
        opening: Double = 1.0
    ) -> AnyTransition {
        .modifier(
            active: VerticalOpenModifier(
                progress: 0,
                smoothness: smoothness,
                opening: opening
            ),
            identity: VerticalOpenModifier(
                progress: 1,
                smoothness: smoothness,
                opening: opening
            )
        )
    }
}

struct VerticalOpenModifier: ViewModifier {
    let progress: Double
    let smoothness: Double
    let opening: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.verticalOpen(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(smoothness),
                            .float(opening)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == VerticalOpenTransition {
    static func verticalOpen(
        smoothness: Double = 0.1,
        opening: Double = 1.0
    ) -> Self {
        VerticalOpenTransition(
            smoothness: smoothness,
            opening: opening
        )
    }
}

public struct VerticalOpenTransition: Transition {
    let smoothness: Double
    let opening: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.verticalOpen(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(smoothness),
                            .float(opening)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
