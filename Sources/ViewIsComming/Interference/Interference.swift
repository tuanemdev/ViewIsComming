import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates an interference pattern effect.
    ///
    /// - Parameters:
    ///   - frequency: Wave frequency (1.0 to 50.0). Default is 20.0.
    ///   - amplitude: Wave amplitude (0.1 to 1.0). Default is 0.5.
    /// - Returns: A transition that creates an interference pattern.
    static func interference(
        frequency: Double = 20.0,
        amplitude: Double = 0.5
    ) -> AnyTransition {
        .modifier(
            active: InterferenceModifier(
                progress: 0,
                frequency: frequency,
                amplitude: amplitude
            ),
            identity: InterferenceModifier(
                progress: 1,
                frequency: frequency,
                amplitude: amplitude
            )
        )
    }
}

struct InterferenceModifier: ViewModifier {
    let progress: Double
    let frequency: Double
    let amplitude: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.interference(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(frequency),
                            .float(amplitude)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == InterferenceTransition {
    /// A transition that creates an interference pattern effect.
    ///
    /// - Parameters:
    ///   - frequency: Wave frequency (1.0 to 50.0). Default is 20.0.
    ///   - amplitude: Wave amplitude (0.1 to 1.0). Default is 0.5.
    /// - Returns: A transition that creates an interference pattern.
    static func interference(
        frequency: Double = 20.0,
        amplitude: Double = 0.5
    ) -> Self {
        InterferenceTransition(
            frequency: frequency,
            amplitude: amplitude
        )
    }
}

public struct InterferenceTransition: Transition {
    let frequency: Double
    let amplitude: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.interference(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(frequency),
                            .float(amplitude)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
