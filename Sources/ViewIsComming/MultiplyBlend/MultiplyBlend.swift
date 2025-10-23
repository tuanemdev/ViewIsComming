import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a multiply blend effect.
    ///
    /// - Parameter intensity: Blend intensity (0.0 to 2.0). Default is 1.0.
    /// - Returns: A transition that creates a multiply blend effect.
    static func multiplyBlend(
        intensity: Double = 1.0
    ) -> AnyTransition {
        .modifier(
            active: MultiplyBlendModifier(
                progress: 0,
                intensity: intensity
            ),
            identity: MultiplyBlendModifier(
                progress: 1,
                intensity: intensity
            )
        )
    }
}

struct MultiplyBlendModifier: ViewModifier {
    let progress: Double
    let intensity: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.multiplyBlend(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(intensity)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == MultiplyBlendTransition {
    /// A transition that creates a multiply blend effect.
    ///
    /// - Parameter intensity: Blend intensity (0.0 to 2.0). Default is 1.0.
    /// - Returns: A transition that creates a multiply blend effect.
    static func multiplyBlend(
        intensity: Double = 1.0
    ) -> Self {
        MultiplyBlendTransition(intensity: intensity)
    }
}

public struct MultiplyBlendTransition: Transition {
    let intensity: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.multiplyBlend(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(intensity)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
