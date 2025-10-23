import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a 3D flip effect.
    ///
    /// - Parameters:
    ///   - axis: Flip axis (0.0 = horizontal, 1.0 = vertical). Default is 0.0.
    ///   - perspective: Perspective strength (0.0 to 2.0). Default is 0.5.
    /// - Returns: A transition that creates a flip effect.
    static func flip(
        axis: Double = 0.0,
        perspective: Double = 0.5
    ) -> AnyTransition {
        .modifier(
            active: FlipModifier(
                progress: 0,
                axis: axis,
                perspective: perspective
            ),
            identity: FlipModifier(
                progress: 1,
                axis: axis,
                perspective: perspective
            )
        )
    }
}

struct FlipModifier: ViewModifier {
    let progress: Double
    let axis: Double
    let perspective: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.flip(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(axis),
                            .float(perspective)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == FlipTransition {
    /// A transition that creates a 3D flip effect.
    ///
    /// - Parameters:
    ///   - axis: Flip axis (0.0 = horizontal, 1.0 = vertical). Default is 0.0.
    ///   - perspective: Perspective strength (0.0 to 2.0). Default is 0.5.
    /// - Returns: A transition that creates a flip effect.
    static func flip(
        axis: Double = 0.0,
        perspective: Double = 0.5
    ) -> Self {
        FlipTransition(
            axis: axis,
            perspective: perspective
        )
    }
}

public struct FlipTransition: Transition {
    let axis: Double
    let perspective: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.flip(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(axis),
                            .float(perspective)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
