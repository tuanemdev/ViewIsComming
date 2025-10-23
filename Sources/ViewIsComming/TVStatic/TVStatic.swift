import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that shows TV static noise in the middle of transition
    /// - Parameter offset: Duration of fade in/out before static (default: 0.05)
    /// - Returns: A custom transition with TV static effect
    static func tvStatic(
        offset: Double = 0.05
    ) -> AnyTransition {
        .modifier(
            active: TVStaticModifier(
                progress: 0,
                offset: offset
            ),
            identity: TVStaticModifier(
                progress: 1,
                offset: offset
            )
        )
    }
}

struct TVStaticModifier: ViewModifier {
    let progress: Double
    let offset: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.tvStatic(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(offset)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == TVStaticTransition {
    /// A transition that shows TV static noise in the middle of transition
    /// - Parameter offset: Duration of fade in/out before static (default: 0.05)
    /// - Returns: A custom transition with TV static effect
    static func tvStatic(
        offset: Double = 0.05
    ) -> Self {
        TVStaticTransition(offset: offset)
    }
}

public struct TVStaticTransition: Transition {
    let offset: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.tvStatic(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(offset)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
