import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a motion blur effect.
    ///
    /// - Parameters:
    ///   - angle: Blur direction angle in degrees. Default is 0.0 (horizontal).
    ///   - samples: Number of blur samples (3 to 20). Default is 10.
    /// - Returns: A transition that creates a motion blur effect.
    static func motionBlur(
        angle: Double = 0.0,
        samples: Int = 10
    ) -> AnyTransition {
        .modifier(
            active: MotionBlurModifier(
                progress: 0,
                angle: angle,
                samples: samples
            ),
            identity: MotionBlurModifier(
                progress: 1,
                angle: angle,
                samples: samples
            )
        )
    }
}

struct MotionBlurModifier: ViewModifier {
    let progress: Double
    let angle: Double
    let samples: Int
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.motionBlur(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(angle),
                            .float(Float(samples))
                        ),
                        maxSampleOffset: CGSize(width: 50, height: 50)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == MotionBlurTransition {
    /// A transition that creates a motion blur effect.
    ///
    /// - Parameters:
    ///   - angle: Blur direction angle in degrees. Default is 0.0 (horizontal).
    ///   - samples: Number of blur samples (3 to 20). Default is 10.
    /// - Returns: A transition that creates a motion blur effect.
    static func motionBlur(
        angle: Double = 0.0,
        samples: Int = 10
    ) -> Self {
        MotionBlurTransition(
            angle: angle,
            samples: samples
        )
    }
}

public struct MotionBlurTransition: Transition {
    let angle: Double
    let samples: Int
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.motionBlur(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(angle),
                            .float(Float(samples))
                        ),
                        maxSampleOffset: CGSize(width: 50, height: 50)
                    )
            }
    }
}
