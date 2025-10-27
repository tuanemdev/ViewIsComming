import SwiftUI

public enum Corner: Float, CaseIterable, Sendable {
    case topLeft = 0
    case topRight = 1
    case bottomRight = 2
    case bottomLeft = 3
}

// MARK: - AnyTransition
public extension AnyTransition {
    static func cornerVanish(
        smoothness: Double = 0.3,
        corner: Corner = .topLeft
    ) -> AnyTransition {
        .modifier(
            active: CornerVanishModifier(
                progress: 0,
                smoothness: smoothness,
                corner: corner
            ),
            identity: CornerVanishModifier(
                progress: 1,
                smoothness: smoothness,
                corner: corner
            )
        )
    }
}

fileprivate struct CornerVanishModifier: ViewModifier {
    let progress: Double
    let smoothness: Double
    let corner: Corner
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.cornerVanish(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(smoothness),
                            .float(corner.rawValue)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == CornerVanishTransition {
    static func cornerVanish(
        smoothness: Double = 0.3,
        corner: Corner = .topLeft
    ) -> Self {
        CornerVanishTransition(
            smoothness: smoothness,
            corner: corner
        )
    }
}

public struct CornerVanishTransition: Transition {
    let smoothness: Double
    let corner: Corner
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.cornerVanish(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(smoothness),
                            .float(corner.rawValue)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
