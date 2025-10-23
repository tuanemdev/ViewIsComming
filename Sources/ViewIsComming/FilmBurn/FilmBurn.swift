import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a film burn effect.
    ///
    /// - Parameters:
    ///   - burnSize: Size of burn variation (0.0 to 1.0). Default is 0.3.
    ///   - intensity: Burn color intensity (0.0 to 2.0). Default is 1.5.
    /// - Returns: A transition that creates a film burn effect.
    static func filmBurn(
        burnSize: Double = 0.3,
        intensity: Double = 1.5
    ) -> AnyTransition {
        .modifier(
            active: FilmBurnModifier(
                progress: 0,
                burnSize: burnSize,
                intensity: intensity
            ),
            identity: FilmBurnModifier(
                progress: 1,
                burnSize: burnSize,
                intensity: intensity
            )
        )
    }
}

struct FilmBurnModifier: ViewModifier {
    let progress: Double
    let burnSize: Double
    let intensity: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.filmBurn(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(burnSize),
                            .float(intensity)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == FilmBurnTransition {
    /// A transition that creates a film burn effect.
    ///
    /// - Parameters:
    ///   - burnSize: Size of burn variation (0.0 to 1.0). Default is 0.3.
    ///   - intensity: Burn color intensity (0.0 to 2.0). Default is 1.5.
    /// - Returns: A transition that creates a film burn effect.
    static func filmBurn(
        burnSize: Double = 0.3,
        intensity: Double = 1.5
    ) -> Self {
        FilmBurnTransition(
            burnSize: burnSize,
            intensity: intensity
        )
    }
}

public struct FilmBurnTransition: Transition {
    let burnSize: Double
    let intensity: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.filmBurn(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(burnSize),
                            .float(intensity)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
