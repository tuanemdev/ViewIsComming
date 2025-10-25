import SwiftUI

// MARK: - Direction Enum
public enum BounceDirection: Sendable {
    case `in`
    case out
    
    var floatValue: Float {
        switch self {
        case .in: return 1.0
        case .out: return 0.0
        }
    }
}

// MARK: - AnyTransition
public extension AnyTransition {
    static func bounce(
        bounces: Double = 4.0
    ) -> AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: BounceModifier(
                    progress: 0,
                    bounces: bounces,
                    direction: .in
                ),
                identity: BounceModifier(
                    progress: 1,
                    bounces: bounces,
                    direction: .in
                )
            ),
            removal: .modifier(
                active: BounceModifier(
                    progress: 1,
                    bounces: bounces,
                    direction: .out
                ),
                identity: BounceModifier(
                    progress: 0,
                    bounces: bounces,
                    direction: .out
                )
            )
        )
    }
}

struct BounceModifier: ViewModifier {
    let progress: Double
    let bounces: Double
    let direction: BounceDirection
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.bounce(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(bounces),
                            .float(direction.floatValue)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == BounceTransition {
    static func bounceIn(
        bounces: Double = 4.0
    ) -> Self {
        BounceTransition(
            bounces: bounces,
            direction: .in
        )
    }
    
    static func bounceOut(
        bounces: Double = 4.0
    ) -> Self {
        BounceTransition(
            bounces: bounces,
            direction: .out
        )
    }
}

public struct BounceTransition: Transition {
    let bounces: Double
    let direction: BounceDirection
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                let progress: Double = if phase.isIdentity {
                    direction == .in ? 1.0 : 0.0
                } else {
                    direction == .in ? 0.0 : 1.0
                }
                return content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.bounce(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(bounces),
                            .float(direction.floatValue)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
