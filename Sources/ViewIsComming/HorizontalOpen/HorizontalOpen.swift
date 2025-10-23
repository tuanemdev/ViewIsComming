import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func horizontalOpen(
        smoothness: Double = 0.1,
        opening: Double = 1.0
    ) -> AnyTransition {
        .modifier(
            active: HorizontalOpenModifier(
                progress: 0,
                smoothness: smoothness,
                opening: opening
            ),
            identity: HorizontalOpenModifier(
                progress: 1,
                smoothness: smoothness,
                opening: opening
            )
        )
    }
}

struct HorizontalOpenModifier: ViewModifier {
    let progress: Double
    let smoothness: Double
    let opening: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.horizontalOpen(
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
public extension Transition where Self == HorizontalOpenTransition {
    static func horizontalOpen(
        smoothness: Double = 0.1,
        opening: Double = 1.0
    ) -> Self {
        HorizontalOpenTransition(
            smoothness: smoothness,
            opening: opening
        )
    }
}

public struct HorizontalOpenTransition: Transition {
    let smoothness: Double
    let opening: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.horizontalOpen(
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
