import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that slides content in a direction with wrapping
    /// - Parameter direction: The direction vector (default: (0, 1) for upward)
    /// - Returns: A custom transition with directional sliding
    static func directional(
        direction: CGVector = CGVector(dx: 0, dy: 1)
    ) -> AnyTransition {
        .modifier(
            active: DirectionalModifier(
                progress: 0,
                direction: direction
            ),
            identity: DirectionalModifier(
                progress: 1,
                direction: direction
            )
        )
    }
}

struct DirectionalModifier: ViewModifier {
    let progress: Double
    let direction: CGVector
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directional(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(direction.dx), Float(direction.dy))
                        ),
                        maxSampleOffset: CGSize(
                            width: abs(direction.dx) * 500,
                            height: abs(direction.dy) * 500
                        )
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DirectionalTransition {
    /// A transition that slides content in a direction with wrapping
    /// - Parameter direction: The direction vector (default: (0, 1) for upward)
    /// - Returns: A custom transition with directional sliding
    static func directional(
        direction: CGVector = CGVector(dx: 0, dy: 1)
    ) -> Self {
        DirectionalTransition(direction: direction)
    }
}

public struct DirectionalTransition: Transition {
    let direction: CGVector
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directional(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(direction.dx), Float(direction.dy))
                        ),
                        maxSampleOffset: CGSize(
                            width: abs(direction.dx) * 500,
                            height: abs(direction.dy) * 500
                        )
                    )
            }
    }
}
