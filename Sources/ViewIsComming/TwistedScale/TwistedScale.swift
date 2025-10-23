import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a twisted scaling effect.
    ///
    /// - Parameters:
    ///   - rotations: Number of rotations (0.1 to 5.0). Default is 2.0.
    ///   - scale: Final scale (0.0 to 2.0). Default is 0.0.
    /// - Returns: A transition that creates a twisted scale effect.
    static func twistedScale(
        rotations: Double = 2.0,
        scale: Double = 0.0
    ) -> AnyTransition {
        .modifier(
            active: TwistedScaleModifier(
                progress: 0,
                rotations: rotations,
                scale: scale
            ),
            identity: TwistedScaleModifier(
                progress: 1,
                rotations: rotations,
                scale: scale
            )
        )
    }
}

struct TwistedScaleModifier: ViewModifier {
    let progress: Double
    let rotations: Double
    let scale: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.twistedScale(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(rotations),
                            .float(scale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == TwistedScaleTransition {
    /// A transition that creates a twisted scaling effect.
    ///
    /// - Parameters:
    ///   - rotations: Number of rotations (0.1 to 5.0). Default is 2.0.
    ///   - scale: Final scale (0.0 to 2.0). Default is 0.0.
    /// - Returns: A transition that creates a twisted scale effect.
    static func twistedScale(
        rotations: Double = 2.0,
        scale: Double = 0.0
    ) -> Self {
        TwistedScaleTransition(
            rotations: rotations,
            scale: scale
        )
    }
}

public struct TwistedScaleTransition: Transition {
    let rotations: Double
    let scale: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.twistedScale(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(rotations),
                            .float(scale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
