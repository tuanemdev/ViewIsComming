import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that zooms and fades simultaneously
    /// - Parameter strength: The zoom intensity (default: 0.4)
    /// - Returns: A custom transition with cross zoom effect
    static func crossZoom(
        strength: Double = 0.4
    ) -> AnyTransition {
        .modifier(
            active: CrossZoomModifier(
                progress: 0,
                strength: strength
            ),
            identity: CrossZoomModifier(
                progress: 1,
                strength: strength
            )
        )
    }
}

struct CrossZoomModifier: ViewModifier {
    let progress: Double
    let strength: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.crossZoom(
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
public extension Transition where Self == CrossZoomTransition {
    /// A transition that zooms and fades simultaneously
    /// - Parameter strength: The zoom intensity (default: 0.4)
    /// - Returns: A custom transition with cross zoom effect
    static func crossZoom(
        strength: Double = 0.4
    ) -> Self {
        CrossZoomTransition(strength: strength)
    }
}

public struct CrossZoomTransition: Transition {
    let strength: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.crossZoom(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(strength)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}
