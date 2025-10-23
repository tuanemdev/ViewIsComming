import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func colourDistance(
        power: Double = 5.0
    ) -> AnyTransition {
        .modifier(
            active: ColourDistanceModifier(
                progress: 0,
                power: power
            ),
            identity: ColourDistanceModifier(
                progress: 1,
                power: power
            )
        )
    }
}

struct ColourDistanceModifier: ViewModifier {
    let progress: Double
    let power: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.colourDistance(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(power)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == ColourDistanceTransition {
    static func colourDistance(
        power: Double = 5.0
    ) -> Self {
        ColourDistanceTransition(power: power)
    }
}

public struct ColourDistanceTransition: Transition {
    let power: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.colourDistance(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(power)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
