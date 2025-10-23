import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that reveals or hides content with a circular mask
    /// - Parameters:
    ///   - smoothness: The softness of the circle edge (default: 0.3)
    ///   - opening: If true, circle expands; if false, circle contracts (default: true)
    /// - Returns: A custom transition with circular opening/closing effect
    static func circleOpen(
        smoothness: Double = 0.3,
        opening: Bool = true
    ) -> AnyTransition {
        .modifier(
            active: CircleOpenModifier(
                progress: 0,
                smoothness: smoothness,
                opening: opening
            ),
            identity: CircleOpenModifier(
                progress: 1,
                smoothness: smoothness,
                opening: opening
            )
        )
    }
}

struct CircleOpenModifier: ViewModifier {
    let progress: Double
    let smoothness: Double
    let opening: Bool
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.circleOpen(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(smoothness),
                            .float(opening ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == CircleOpenTransition {
    /// A transition that reveals or hides content with a circular mask
    /// - Parameters:
    ///   - smoothness: The softness of the circle edge (default: 0.3)
    ///   - opening: If true, circle expands; if false, circle contracts (default: true)
    /// - Returns: A custom transition with circular opening/closing effect
    static func circleOpen(
        smoothness: Double = 0.3,
        opening: Bool = true
    ) -> Self {
        CircleOpenTransition(
            smoothness: smoothness,
            opening: opening
        )
    }
}

public struct CircleOpenTransition: Transition {
    let smoothness: Double
    let opening: Bool
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.circleOpen(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(smoothness),
                            .float(opening ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
