import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that squeezes the content vertically with chromatic aberration
    /// - Parameter colorSeparation: Amount of color channel separation (default: 0.04)
    /// - Returns: A custom transition with vertical squeeze effect
    static func squeeze(
        colorSeparation: Double = 0.04
    ) -> AnyTransition {
        .modifier(
            active: SqueezeModifier(
                progress: 0,
                colorSeparation: colorSeparation
            ),
            identity: SqueezeModifier(
                progress: 1,
                colorSeparation: colorSeparation
            )
        )
    }
}

struct SqueezeModifier: ViewModifier {
    let progress: Double
    let colorSeparation: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.squeeze(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(colorSeparation)
                        ),
                        maxSampleOffset: CGSize(width: 0, height: 10)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == SqueezeTransition {
    /// A transition that squeezes the content vertically with chromatic aberration
    /// - Parameter colorSeparation: Amount of color channel separation (default: 0.04)
    /// - Returns: A custom transition with vertical squeeze effect
    static func squeeze(
        colorSeparation: Double = 0.04
    ) -> Self {
        SqueezeTransition(colorSeparation: colorSeparation)
    }
}

public struct SqueezeTransition: Transition {
    let colorSeparation: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.squeeze(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(colorSeparation)
                        ),
                        maxSampleOffset: CGSize(width: 0, height: 10)
                    )
            }
    }
}
