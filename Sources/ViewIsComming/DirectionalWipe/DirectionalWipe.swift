import SwiftUI

public enum DirectionalWipeDirection {
    case up
    case down
    case left
    case right
    
    public var opposite: DirectionalWipeDirection {
        switch self {
        case .up: return .down
        case .down: return .up
        case .left: return .right
        case .right: return .left
        }
    }
    
    var vector: CGVector {
        switch self {
        case .up: return CGVector(dx: 0, dy: -1)
        case .down: return CGVector(dx: 0, dy: 1)
        case .left: return CGVector(dx: -1, dy: 0)
        case .right: return CGVector(dx: 1, dy: 0)
        }
    }
}

// MARK: - AnyTransition
public extension AnyTransition {
    static func directionalWipe(
        direction: DirectionalWipeDirection = .right,
        smoothness: Double = 0.5
    ) -> AnyTransition {
        .modifier(
            active: DirectionalWipeModifier(
                progress: 0,
                direction: direction.vector,
                smoothness: smoothness
            ),
            identity: DirectionalWipeModifier(
                progress: 1,
                direction: direction.vector,
                smoothness: smoothness
            )
        )
    }
}

struct DirectionalWipeModifier: ViewModifier {
    let progress: Double
    let direction: CGVector
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directionalWipe(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(direction.dx), Float(direction.dy)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == DirectionalWipeTransition {
    static func directionalWipe(
        direction: DirectionalWipeDirection = .right,
        smoothness: Double = 0.5
    ) -> Self {
        DirectionalWipeTransition(
            direction: direction.vector,
            smoothness: smoothness
        )
    }
}

public struct DirectionalWipeTransition: Transition {
    let direction: CGVector
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directionalWipe(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(direction.dx), Float(direction.dy)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
