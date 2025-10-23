import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that zooms in/out from the center
    /// - Parameter strength: The maximum zoom amount (default: 0.4)
    /// - Returns: A custom transition with zoom effect
    static func zoom(
        strength: Double = 0.4
    ) -> AnyTransition {
        .modifier(
            active: ZoomModifier(
                progress: 0,
                strength: strength
            ),
            identity: ZoomModifier(
                progress: 1,
                strength: strength
            )
        )
    }
}

struct ZoomModifier: ViewModifier {
    let progress: Double
    let strength: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.zoom(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(strength)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == ZoomTransition {
    /// A transition that zooms in/out from the center
    /// - Parameter strength: The maximum zoom amount (default: 0.4)
    /// - Returns: A custom transition with zoom effect
    static func zoom(
        strength: Double = 0.4
    ) -> Self {
        ZoomTransition(strength: strength)
    }
}

public struct ZoomTransition: Transition {
    let strength: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.zoom(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(strength)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}
