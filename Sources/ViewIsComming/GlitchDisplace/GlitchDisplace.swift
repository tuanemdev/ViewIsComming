import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a glitch displacement effect.
    ///
    /// - Parameters:
    ///   - intensity: Glitch displacement intensity (0.0 to 1.0). Default is 0.5.
    ///   - frequency: Glitch frequency (5.0 to 50.0). Default is 20.0.
    /// - Returns: A transition that creates a glitch displace effect.
    static func glitchDisplace(
        intensity: Double = 0.5,
        frequency: Double = 20.0
    ) -> AnyTransition {
        .modifier(
            active: GlitchDisplaceModifier(
                progress: 0,
                intensity: intensity,
                frequency: frequency
            ),
            identity: GlitchDisplaceModifier(
                progress: 1,
                intensity: intensity,
                frequency: frequency
            )
        )
    }
}

struct GlitchDisplaceModifier: ViewModifier {
    let progress: Double
    let intensity: Double
    let frequency: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.glitchDisplace(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(intensity),
                            .float(frequency)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 0)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == GlitchDisplaceTransition {
    /// A transition that creates a glitch displacement effect.
    ///
    /// - Parameters:
    ///   - intensity: Glitch displacement intensity (0.0 to 1.0). Default is 0.5.
    ///   - frequency: Glitch frequency (5.0 to 50.0). Default is 20.0.
    /// - Returns: A transition that creates a glitch displace effect.
    static func glitchDisplace(
        intensity: Double = 0.5,
        frequency: Double = 20.0
    ) -> Self {
        GlitchDisplaceTransition(
            intensity: intensity,
            frequency: frequency
        )
    }
}

public struct GlitchDisplaceTransition: Transition {
    let intensity: Double
    let frequency: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.glitchDisplace(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(intensity),
                            .float(frequency)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 0)
                    )
            }
    }
}
