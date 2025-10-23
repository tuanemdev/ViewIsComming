import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a bouncing effect.
    ///
    /// - Parameters:
    ///   - bounces: Number of bounces (1.0 to 10.0). Default is 4.0.
    ///   - shadowAlpha: Shadow opacity (0.0 to 1.0). Default is 0.6.
    ///   - shadowHeight: Shadow size (0.0 to 0.3). Default is 0.075.
    /// - Returns: A transition that creates a bounce effect.
    static func bounce(
        bounces: Double = 4.0,
        shadowAlpha: Double = 0.6,
        shadowHeight: Double = 0.075
    ) -> AnyTransition {
        .modifier(
            active: BounceModifier(
                progress: 0,
                bounces: bounces,
                shadowAlpha: shadowAlpha,
                shadowHeight: shadowHeight
            ),
            identity: BounceModifier(
                progress: 1,
                bounces: bounces,
                shadowAlpha: shadowAlpha,
                shadowHeight: shadowHeight
            )
        )
    }
}

struct BounceModifier: ViewModifier {
    let progress: Double
    let bounces: Double
    let shadowAlpha: Double
    let shadowHeight: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.bounce(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(bounces),
                            .float(shadowAlpha),
                            .float(shadowHeight)
                        ),
                        maxSampleOffset: CGSize(width: 0, height: 50)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == BounceTransition {
    /// A transition that creates a bouncing effect.
    ///
    /// - Parameters:
    ///   - bounces: Number of bounces (1.0 to 10.0). Default is 4.0.
    ///   - shadowAlpha: Shadow opacity (0.0 to 1.0). Default is 0.6.
    ///   - shadowHeight: Shadow size (0.0 to 0.3). Default is 0.075.
    /// - Returns: A transition that creates a bounce effect.
    static func bounce(
        bounces: Double = 4.0,
        shadowAlpha: Double = 0.6,
        shadowHeight: Double = 0.075
    ) -> Self {
        BounceTransition(
            bounces: bounces,
            shadowAlpha: shadowAlpha,
            shadowHeight: shadowHeight
        )
    }
}

public struct BounceTransition: Transition {
    let bounces: Double
    let shadowAlpha: Double
    let shadowHeight: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.bounce(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(bounces),
                            .float(shadowAlpha),
                            .float(shadowHeight)
                        ),
                        maxSampleOffset: CGSize(width: 0, height: 50)
                    )
            }
    }
}
