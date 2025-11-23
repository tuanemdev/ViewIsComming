import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func doomScreen(
        bars: Int = 30,
        amplitude: Double = 2.0,
        noise: Double = 0.1,
        frequency: Double = 0.5,
        dripScale: Double = 0.5
    ) -> AnyTransition {
        .modifier(
            active: DoomScreenModifier(
                progress: 0,
                bars: bars,
                amplitude: amplitude,
                noise: noise,
                frequency: frequency,
                dripScale: dripScale
            ),
            identity: DoomScreenModifier(
                progress: 1,
                bars: bars,
                amplitude: amplitude,
                noise: noise,
                frequency: frequency,
                dripScale: dripScale
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
    let dripScale: Double
    
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
                            .float(frequency),
                            .float(dripScale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == DoomScreenTransition {
    static func doomScreen(
        bars: Int = 30,
        amplitude: Double = 2.0,
        noise: Double = 0.1,
        frequency: Double = 0.5,
        dripScale: Double = 0.5
    ) -> Self {
        DoomScreenTransition(
            bars: bars,
            amplitude: amplitude,
            noise: noise,
            frequency: frequency,
            dripScale: dripScale
        )
    }
}

public struct DoomScreenTransition: Transition {
    let bars: Int
    let amplitude: Double
    let noise: Double
    let frequency: Double
    let dripScale: Double
    
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
                            .float(frequency),
                            .float(dripScale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
