import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a directional motion blur effect.
    ///
    /// - Parameters:
    ///   - direction: Blur direction (x, y). Default is (1, 0) for horizontal.
    ///   - samples: Number of samples (5 to 30). Default is 15.
    /// - Returns: A transition that creates a directional blur effect.
    static func directionalBlur(
        direction: CGPoint = CGPoint(x: 1, y: 0),
        samples: Double = 15.0
    ) -> AnyTransition {
        .modifier(
            active: DirectionalBlurModifier(
                progress: 0,
                direction: direction,
                samples: samples
            ),
            identity: DirectionalBlurModifier(
                progress: 1,
                direction: direction,
                samples: samples
            )
        )
    }
}

struct DirectionalBlurModifier: ViewModifier {
    let progress: Double
    let direction: CGPoint
    let samples: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directionalBlur(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(samples)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DirectionalBlurTransition {
    /// A transition that creates a directional motion blur effect.
    ///
    /// - Parameters:
    ///   - direction: Blur direction (x, y). Default is (1, 0) for horizontal.
    ///   - samples: Number of samples (5 to 30). Default is 15.
    /// - Returns: A transition that creates a directional blur effect.
    static func directionalBlur(
        direction: CGPoint = CGPoint(x: 1, y: 0),
        samples: Double = 15.0
    ) -> Self {
        DirectionalBlurTransition(
            direction: direction,
            samples: samples
        )
    }
}

public struct DirectionalBlurTransition: Transition {
    let direction: CGPoint
    let samples: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directionalBlur(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(samples)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}
