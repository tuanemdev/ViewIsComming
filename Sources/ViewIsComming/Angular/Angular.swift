import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func angular(
        startingAngle: Angle = .degrees(90),
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

fileprivate struct AngularModifier: ViewModifier {
    let progress: Double
    let startingAngle: Angle
    let clockwise: Bool
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.angular(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(startingAngle.degrees),
                            .float(clockwise ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == AngularTransition {
    static func angular(
        startingAngle: Angle = .degrees(90),
        clockwise: Bool = true
    ) -> Self {
        AngularTransition(
            startingAngle: startingAngle,
            clockwise: clockwise
        )
    }
}

public struct AngularTransition: Transition {
    let startingAngle: Angle
    let clockwise: Bool
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.angular(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(startingAngle.degrees),
                            .float(clockwise ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
