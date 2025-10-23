import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that combines rotation and scaling to create a vanishing effect.
    ///
    /// - Parameters:
    ///   - rotations: Number of rotations (0.5 to 5.0). Default is 2.0.
    ///   - scaleAmount: Final scale factor (0.0 to 5.0). Default is 0.0 (vanish).
    /// - Returns: A transition that creates a rotate and scale vanishing effect.
    static func rotateScaleVanish(
        rotations: Double = 2.0,
        scaleAmount: Double = 0.0
    ) -> AnyTransition {
        .modifier(
            active: RotateScaleVanishModifier(
                progress: 0,
                rotations: rotations,
                scaleAmount: scaleAmount
            ),
            identity: RotateScaleVanishModifier(
                progress: 1,
                rotations: rotations,
                scaleAmount: scaleAmount
            )
        )
    }
}

struct RotateScaleVanishModifier: ViewModifier {
    let progress: Double
    let rotations: Double
    let scaleAmount: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.rotateScaleVanish(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(rotations),
                            .float(scaleAmount)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == RotateScaleVanishTransition {
    /// A transition that combines rotation and scaling to create a vanishing effect.
    ///
    /// - Parameters:
    ///   - rotations: Number of rotations (0.5 to 5.0). Default is 2.0.
    ///   - scaleAmount: Final scale factor (0.0 to 5.0). Default is 0.0 (vanish).
    /// - Returns: A transition that creates a rotate and scale vanishing effect.
    static func rotateScaleVanish(
        rotations: Double = 2.0,
        scaleAmount: Double = 0.0
    ) -> Self {
        RotateScaleVanishTransition(
            rotations: rotations,
            scaleAmount: scaleAmount
        )
    }
}

public struct RotateScaleVanishTransition: Transition {
    let rotations: Double
    let scaleAmount: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.rotateScaleVanish(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(rotations),
                            .float(scaleAmount)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
