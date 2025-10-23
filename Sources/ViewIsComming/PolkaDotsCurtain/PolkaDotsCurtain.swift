import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that reveals through polka dot pattern from a center point
    /// - Parameters:
    ///   - dots: Number of dots (default: 20.0)
    ///   - center: Center point for the transition (default: (0.5, 0.5))
    /// - Returns: A custom transition with polka dot curtain effect
    static func polkaDotsCurtain(
        dots: Double = 20.0,
        center: CGPoint = CGPoint(x: 0.5, y: 0.5)
    ) -> AnyTransition {
        .modifier(
            active: PolkaDotsCurtainModifier(
                progress: 0,
                dots: dots,
                center: center
            ),
            identity: PolkaDotsCurtainModifier(
                progress: 1,
                dots: dots,
                center: center
            )
        )
    }
}

struct PolkaDotsCurtainModifier: ViewModifier {
    let progress: Double
    let dots: Double
    let center: CGPoint
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.polkaDotsCurtain(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(dots),
                            .float2(Float(center.x), Float(center.y))
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == PolkaDotsCurtainTransition {
    /// A transition that reveals through polka dot pattern from a center point
    /// - Parameters:
    ///   - dots: Number of dots (default: 20.0)
    ///   - center: Center point for the transition (default: (0.5, 0.5))
    /// - Returns: A custom transition with polka dot curtain effect
    static func polkaDotsCurtain(
        dots: Double = 20.0,
        center: CGPoint = CGPoint(x: 0.5, y: 0.5)
    ) -> Self {
        PolkaDotsCurtainTransition(dots: dots, center: center)
    }
}

public struct PolkaDotsCurtainTransition: Transition {
    let dots: Double
    let center: CGPoint
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.polkaDotsCurtain(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(dots),
                            .float2(Float(center.x), Float(center.y))
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
