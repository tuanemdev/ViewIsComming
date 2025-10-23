import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a powerful kaleidoscope effect.
    ///
    /// - Parameters:
    ///   - speed: Rotation speed (0.0 to 10.0). Default is 2.0.
    ///   - angle: Starting angle in degrees. Default is 0.0.
    ///   - power: Number of segments (1.0 to 8.0). Default is 2.0.
    /// - Returns: A transition that creates a kaleidoscope effect.
    static func powerKaleido(
        speed: Double = 2.0,
        angle: Double = 0.0,
        power: Double = 2.0
    ) -> AnyTransition {
        .modifier(
            active: PowerKaleidoModifier(
                progress: 0,
                speed: speed,
                angle: angle,
                power: power
            ),
            identity: PowerKaleidoModifier(
                progress: 1,
                speed: speed,
                angle: angle,
                power: power
            )
        )
    }
}

struct PowerKaleidoModifier: ViewModifier {
    let progress: Double
    let speed: Double
    let angle: Double
    let power: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.powerKaleido(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(speed),
                            .float(angle),
                            .float(power)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == PowerKaleidoTransition {
    /// A transition that creates a powerful kaleidoscope effect.
    ///
    /// - Parameters:
    ///   - speed: Rotation speed (0.0 to 10.0). Default is 2.0.
    ///   - angle: Starting angle in degrees. Default is 0.0.
    ///   - power: Number of segments (1.0 to 8.0). Default is 2.0.
    /// - Returns: A transition that creates a kaleidoscope effect.
    static func powerKaleido(
        speed: Double = 2.0,
        angle: Double = 0.0,
        power: Double = 2.0
    ) -> Self {
        PowerKaleidoTransition(
            speed: speed,
            angle: angle,
            power: power
        )
    }
}

public struct PowerKaleidoTransition: Transition {
    let speed: Double
    let angle: Double
    let power: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.powerKaleido(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(speed),
                            .float(angle),
                            .float(power)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
