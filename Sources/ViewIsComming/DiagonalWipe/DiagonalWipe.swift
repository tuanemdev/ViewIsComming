import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func diagonalWipe(
        direction: CGPoint = CGPoint(x: 1, y: 1),
        smoothness: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: DiagonalWipeModifier(
                progress: 0,
                direction: direction,
                smoothness: smoothness
            ),
            identity: DiagonalWipeModifier(
                progress: 1,
                direction: direction,
                smoothness: smoothness
            )
        )
    }
}

struct DiagonalWipeModifier: ViewModifier {
    let progress: Double
    let direction: CGPoint
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.diagonalWipe(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DiagonalWipeTransition {
    static func diagonalWipe(
        direction: CGPoint = CGPoint(x: 1, y: 1),
        smoothness: Double = 0.1
    ) -> Self {
        DiagonalWipeTransition(
            direction: direction,
            smoothness: smoothness
        )
    }
}

public struct DiagonalWipeTransition: Transition {
    let direction: CGPoint
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.diagonalWipe(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
