import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func angular(
        startingAngle: Double = 90,
        clockwise: Bool = true
    ) -> AnyTransition {
        .modifier(
            active: AngularModifier(
                progress: 0,
                startingAngle: startingAngle,
                clockwise: clockwise
            ),
            identity: AngularModifier(
                progress: 1,
                startingAngle: startingAngle,
                clockwise: clockwise
            )
        )
    }
}

struct AngularModifier: ViewModifier {
    let progress: Double
    let startingAngle: Double
    let clockwise: Bool
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.angular(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(startingAngle),
                            .float(clockwise ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == AngularTransition {
    static func angular(
        startingAngle: Double = 90,
        clockwise: Bool = true
    ) -> Self {
        AngularTransition(
            startingAngle: startingAngle,
            clockwise: clockwise
        )
    }
}

public struct AngularTransition: Transition {
    let startingAngle: Double
    let clockwise: Bool
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.angular(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(startingAngle),
                            .float(clockwise ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
