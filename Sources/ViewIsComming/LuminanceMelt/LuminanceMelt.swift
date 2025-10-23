import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func luminanceMelt(
        direction: Double = 1.0,
        threshold: Double = 0.5,
        smoothness: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: LuminanceMeltModifier(
                progress: 0,
                direction: direction,
                threshold: threshold,
                smoothness: smoothness
            ),
            identity: LuminanceMeltModifier(
                progress: 1,
                direction: direction,
                threshold: threshold,
                smoothness: smoothness
            )
        )
    }
}

struct LuminanceMeltModifier: ViewModifier {
    let progress: Double
    let direction: Double
    let threshold: Double
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.luminanceMelt(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(direction),
                            .float(threshold),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == LuminanceMeltTransition {
    static func luminanceMelt(
        direction: Double = 1.0,
        threshold: Double = 0.5,
        smoothness: Double = 0.1
    ) -> Self {
        LuminanceMeltTransition(
            direction: direction,
            threshold: threshold,
            smoothness: smoothness
        )
    }
}

public struct LuminanceMeltTransition: Transition {
    let direction: Double
    let threshold: Double
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.luminanceMelt(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(direction),
                            .float(threshold),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
