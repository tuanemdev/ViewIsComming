import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func wave(
        amplitude: Double = 0.1,
        waves: Double = 5.0
    ) -> AnyTransition {
        .modifier(
            active: WaveModifier(
                progress: 0,
                amplitude: amplitude,
                waves: waves
            ),
            identity: WaveModifier(
                progress: 1,
                amplitude: amplitude,
                waves: waves
            )
        )
    }
}

struct WaveModifier: ViewModifier {
    let progress: Double
    let amplitude: Double
    let waves: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.wave(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(amplitude),
                            .float(waves)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == WaveTransition {
    static func wave(
        amplitude: Double = 0.1,
        waves: Double = 5.0
    ) -> Self {
        WaveTransition(
            amplitude: amplitude,
            waves: waves
        )
    }
}

public struct WaveTransition: Transition {
    let amplitude: Double
    let waves: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.wave(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(amplitude),
                            .float(waves)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
