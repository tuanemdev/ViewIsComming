import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func butterflyWaveScrawler(
        amplitude: Double = 1.0,
        waves: Double = 30.0,
        colorSeparation: Double = 0.3
    ) -> AnyTransition {
        .modifier(
            active: ButterflyWaveScrawlerModifier(
                progress: 0,
                amplitude: amplitude,
                waves: waves,
                colorSeparation: colorSeparation
            ),
            identity: ButterflyWaveScrawlerModifier(
                progress: 1,
                amplitude: amplitude,
                waves: waves,
                colorSeparation: colorSeparation
            )
        )
    }
}

struct ButterflyWaveScrawlerModifier: ViewModifier {
    let progress: Double
    let amplitude: Double
    let waves: Double
    let colorSeparation: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.butterflyWaveScrawler(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(amplitude),
                            .float(waves),
                            .float(colorSeparation)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == ButterflyWaveScrawlerTransition {
    static func butterflyWaveScrawler(
        amplitude: Double = 1.0,
        waves: Double = 30.0,
        colorSeparation: Double = 0.3
    ) -> Self {
        ButterflyWaveScrawlerTransition(
            amplitude: amplitude,
            waves: waves,
            colorSeparation: colorSeparation
        )
    }
}

public struct ButterflyWaveScrawlerTransition: Transition {
    let amplitude: Double
    let waves: Double
    let colorSeparation: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.butterflyWaveScrawler(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(amplitude),
                            .float(waves),
                            .float(colorSeparation)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
