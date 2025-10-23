import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a circular scaling effect.
    ///
    /// - Parameters:
    ///   - scale: Final scale (0.0 to 2.0). Default is 0.0 (vanish).
    ///   - smoothness: Edge smoothness (0.0 to 1.0). Default is 0.3.
    /// - Returns: A transition that creates a circular scale effect.
    static func circularScale(
        scale: Double = 0.0,
        smoothness: Double = 0.3
    ) -> AnyTransition {
        .modifier(
            active: CircularScaleModifier(
                progress: 0,
                scale: scale,
                smoothness: smoothness
            ),
            identity: CircularScaleModifier(
                progress: 1,
                scale: scale,
                smoothness: smoothness
            )
        )
    }
}

struct CircularScaleModifier: ViewModifier {
    let progress: Double
    let scale: Double
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.circularScale(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(scale),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == CircularScaleTransition {
    /// A transition that creates a circular scaling effect.
    ///
    /// - Parameters:
    ///   - scale: Final scale (0.0 to 2.0). Default is 0.0 (vanish).
    ///   - smoothness: Edge smoothness (0.0 to 1.0). Default is 0.3.
    /// - Returns: A transition that creates a circular scale effect.
    static func circularScale(
        scale: Double = 0.0,
        smoothness: Double = 0.3
    ) -> Self {
        CircularScaleTransition(
            scale: scale,
            smoothness: smoothness
        )
    }
}

public struct CircularScaleTransition: Transition {
    let scale: Double
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.circularScale(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(scale),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
