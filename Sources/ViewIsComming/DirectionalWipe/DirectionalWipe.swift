import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that wipes in a custom direction with smooth edges
    /// - Parameters:
    ///   - direction: The direction vector for the wipe (default: (1, 1) for diagonal)
    ///   - smoothness: The softness of the wipe edge (default: 0.5)
    /// - Returns: A custom transition with directional wipe effect
    static func directionalWipe(
        direction: CGVector = CGVector(dx: 1, dy: 1),
        smoothness: Double = 0.5
    ) -> AnyTransition {
        .modifier(
            active: DirectionalWipeModifier(
                progress: 0,
                direction: direction,
                smoothness: smoothness
            ),
            identity: DirectionalWipeModifier(
                progress: 1,
                direction: direction,
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

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DirectionalWipeTransition {
    /// A transition that wipes in a custom direction with smooth edges
    /// - Parameters:
    ///   - direction: The direction vector for the wipe (default: (1, 1) for diagonal)
    ///   - smoothness: The softness of the wipe edge (default: 0.5)
    /// - Returns: A custom transition with directional wipe effect
    static func directionalWipe(
        direction: CGVector = CGVector(dx: 1, dy: 1),
        smoothness: Double = 0.5
    ) -> Self {
        DirectionalWipeTransition(
            direction: direction,
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
