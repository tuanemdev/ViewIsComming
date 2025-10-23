import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func squaresWire(
        squares: CGSize = CGSize(width: 10, height: 10),
        direction: CGPoint = CGPoint(x: 1.0, y: -0.5),
        smoothness: Double = 1.6
    ) -> AnyTransition {
        .modifier(
            active: SquaresWireModifier(
                progress: 0,
                squares: squares,
                direction: direction,
                smoothness: smoothness
            ),
            identity: SquaresWireModifier(
                progress: 1,
                squares: squares,
                direction: direction,
                smoothness: smoothness
            )
        )
    }
}

struct SquaresWireModifier: ViewModifier {
    let progress: Double
    let squares: CGSize
    let direction: CGPoint
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.squaresWire(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(squares.width), Float(squares.height)),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == SquaresWireTransition {
    static func squaresWire(
        squares: CGSize = CGSize(width: 10, height: 10),
        direction: CGPoint = CGPoint(x: 1.0, y: -0.5),
        smoothness: Double = 1.6
    ) -> Self {
        SquaresWireTransition(
            squares: squares,
            direction: direction,
            smoothness: smoothness
        )
    }
}

public struct SquaresWireTransition: Transition {
    let squares: CGSize
    let direction: CGPoint
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.squaresWire(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(squares.width), Float(squares.height)),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
