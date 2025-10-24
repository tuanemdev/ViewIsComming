import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func kaleidoscope(
        speed: Double = 1.0,
        angle: Double = 1.0,
        power: Double = 1.5
    ) -> AnyTransition {
        .modifier(
            active: KaleidoscopeModifier(
                progress: 0,
                speed: speed,
                angle: angle,
                power: power
            ),
            identity: KaleidoscopeModifier(
                progress: 1,
                speed: speed,
                angle: angle,
                power: power
            )
        )
    }
}

struct KaleidoscopeModifier: ViewModifier {
    let progress: Double
    let speed: Double
    let angle: Double
    let power: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.kaleidoscope(
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
public extension Transition where Self == KaleidoscopeTransition {
    static func kaleidoscope(
        speed: Double = 1.0,
        angle: Double = 1.0,
        power: Double = 1.5
    ) -> Self {
        KaleidoscopeTransition(
            speed: speed,
            angle: angle,
            power: power
        )
    }
}

public struct KaleidoscopeTransition: Transition {
    let speed: Double
    let angle: Double
    let power: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.kaleidoscope(
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
