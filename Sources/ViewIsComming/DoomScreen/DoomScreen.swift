import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a Doom screen melt effect.
    ///
    /// - Parameters:
    ///   - bars: Number of vertical bars (10 to 100). Default is 30.
    ///   - amplitude: Wave amplitude (0.0 to 0.5). Default is 0.2.
    ///   - noise: Random variation (0.0 to 1.0). Default is 0.1.
    ///   - frequency: Wave frequency (1.0 to 20.0). Default is 6.0.
    /// - Returns: A transition that creates a doom screen effect.
    static func doomScreen(
        bars: Int = 30,
        amplitude: Double = 0.2,
        noise: Double = 0.1,
        frequency: Double = 6.0
    ) -> AnyTransition {
        .modifier(
            active: DoomScreenModifier(
                progress: 0,
                bars: bars,
                amplitude: amplitude,
                noise: noise,
                frequency: frequency
            ),
            identity: DoomScreenModifier(
                progress: 1,
                bars: bars,
                amplitude: amplitude,
                noise: noise,
                frequency: frequency
            )
        )
    }
}

struct DoomScreenModifier: ViewModifier {
    let progress: Double
    let bars: Int
    let amplitude: Double
    let noise: Double
    let frequency: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.doomScreen(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(Float(bars)),
                            .float(amplitude),
                            .float(noise),
                            .float(frequency)
                        ),
                        maxSampleOffset: CGSize(width: 0, height: 100)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DoomScreenTransition {
    /// A transition that creates a Doom screen melt effect.
    ///
    /// - Parameters:
    ///   - bars: Number of vertical bars (10 to 100). Default is 30.
    ///   - amplitude: Wave amplitude (0.0 to 0.5). Default is 0.2.
    ///   - noise: Random variation (0.0 to 1.0). Default is 0.1.
    ///   - frequency: Wave frequency (1.0 to 20.0). Default is 6.0.
    /// - Returns: A transition that creates a doom screen effect.
    static func doomScreen(
        bars: Int = 30,
        amplitude: Double = 0.2,
        noise: Double = 0.1,
        frequency: Double = 6.0
    ) -> Self {
        DoomScreenTransition(
            bars: bars,
            amplitude: amplitude,
            noise: noise,
            frequency: frequency
        )
    }
}

public struct DoomScreenTransition: Transition {
    let bars: Int
    let amplitude: Double
    let noise: Double
    let frequency: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.doomScreen(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(Float(bars)),
                            .float(amplitude),
                            .float(noise),
                            .float(frequency)
                        ),
                        maxSampleOffset: CGSize(width: 0, height: 100)
                    )
            }
    }
}
