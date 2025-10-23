import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that swaps the view with a 3D flip effect.
    ///
    /// - Parameters:
    ///   - reflection: Reflection strength in the middle (0.0 to 1.0). Default is 0.4.
    ///   - perspective: Perspective strength (0.0 to 2.0). Default is 0.4.
    ///   - depth: Depth of the 3D effect (0.0 to 2.0). Default is 3.0.
    /// - Returns: A transition that creates a 3D flip swap effect.
    static func swap(
        reflection: Double = 0.4,
        perspective: Double = 0.4,
        depth: Double = 3.0
    ) -> AnyTransition {
        .modifier(
            active: SwapModifier(
                progress: 0,
                reflection: reflection,
                perspective: perspective,
                depth: depth
            ),
            identity: SwapModifier(
                progress: 1,
                reflection: reflection,
                perspective: perspective,
                depth: depth
            )
        )
    }
}

struct SwapModifier: ViewModifier {
    let progress: Double
    let reflection: Double
    let perspective: Double
    let depth: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.swap(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(reflection),
                            .float(perspective),
                            .float(depth)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == SwapTransition {
    /// A transition that swaps the view with a 3D flip effect.
    ///
    /// - Parameters:
    ///   - reflection: Reflection strength in the middle (0.0 to 1.0). Default is 0.4.
    ///   - perspective: Perspective strength (0.0 to 2.0). Default is 0.4.
    ///   - depth: Depth of the 3D effect (0.0 to 2.0). Default is 3.0.
    /// - Returns: A transition that creates a 3D flip swap effect.
    static func swap(
        reflection: Double = 0.4,
        perspective: Double = 0.4,
        depth: Double = 3.0
    ) -> Self {
        SwapTransition(
            reflection: reflection,
            perspective: perspective,
            depth: depth
        )
    }
}

public struct SwapTransition: Transition {
    let reflection: Double
    let perspective: Double
    let depth: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.swap(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(reflection),
                            .float(perspective),
                            .float(depth)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
