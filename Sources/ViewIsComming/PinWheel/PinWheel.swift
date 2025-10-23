import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func pinWheel(
        speed: Double = 2.0
    ) -> AnyTransition {
        .modifier(
            active: PinWheelModifier(
                progress: 0,
                speed: speed
            ),
            identity: PinWheelModifier(
                progress: 1,
                speed: speed
            )
        )
    }
}

struct PinWheelModifier: ViewModifier {
    let progress: Double
    let speed: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.pinWheel(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(speed)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == PinWheelTransition {
    static func pinWheel(
        speed: Double = 2.0
    ) -> Self {
        PinWheelTransition(
            speed: speed
        )
    }
}

public struct PinWheelTransition: Transition {
    let speed: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.pinWheel(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(speed)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
