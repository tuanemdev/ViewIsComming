import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func randomSquares(
        size: CGSize = CGSize(width: 10, height: 10),
        smoothness: Double = 0.5
    ) -> AnyTransition {
        .modifier(
            active: RandomSquaresModifier(
                progress: 0,
                size: size,
                smoothness: smoothness
            ),
            identity: RandomSquaresModifier(
                progress: 1,
                size: size,
                smoothness: smoothness
            )
        )
    }
}

struct RandomSquaresModifier: ViewModifier {
    let progress: Double
    let size: CGSize
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.randomSquares(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(size.width), Float(size.height)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == RandomSquaresTransition {
    static func randomSquares(
        size: CGSize = CGSize(width: 10, height: 10),
        smoothness: Double = 0.5
    ) -> Self {
        RandomSquaresTransition(
            size: size,
            smoothness: smoothness
        )
    }
}

public struct RandomSquaresTransition: Transition {
    let size: CGSize
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.randomSquares(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(size.width), Float(size.height)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
