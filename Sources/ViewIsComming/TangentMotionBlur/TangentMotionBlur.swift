import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a tangent motion blur effect.
    ///
    /// - Parameters:
    ///   - radius: Blur radius (0.0 to 2.0). Default is 1.0.
    ///   - samples: Number of samples (5 to 30). Default is 10.
    /// - Returns: A transition that creates a tangent motion blur effect.
    static func tangentMotionBlur(
        radius: Double = 1.0,
        samples: Double = 10.0
    ) -> AnyTransition {
        .modifier(
            active: TangentMotionBlurModifier(
                progress: 0,
                radius: radius,
                samples: samples
            ),
            identity: TangentMotionBlurModifier(
                progress: 1,
                radius: radius,
                samples: samples
            )
        )
    }
}

struct TangentMotionBlurModifier: ViewModifier {
    let progress: Double
    let radius: Double
    let samples: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.tangentMotionBlur(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(radius),
                            .float(samples)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == TangentMotionBlurTransition {
    /// A transition that creates a tangent motion blur effect.
    ///
    /// - Parameters:
    ///   - radius: Blur radius (0.0 to 2.0). Default is 1.0.
    ///   - samples: Number of samples (5 to 30). Default is 10.
    /// - Returns: A transition that creates a tangent motion blur effect.
    static func tangentMotionBlur(
        radius: Double = 1.0,
        samples: Double = 10.0
    ) -> Self {
        TangentMotionBlurTransition(
            radius: radius,
            samples: samples
        )
    }
}

public struct TangentMotionBlurTransition: Transition {
    let radius: Double
    let samples: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.tangentMotionBlur(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(radius),
                            .float(samples)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}
