import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func directionalEasing(
        direction: CGPoint = CGPoint(x: 1, y: 0),
        scale: Double = 0.5
    ) -> AnyTransition {
        .modifier(
            active: DirectionalEasingModifier(
                progress: 0,
                direction: direction,
                scale: scale
            ),
            identity: DirectionalEasingModifier(
                progress: 1,
                direction: direction,
                scale: scale
            )
        )
    }
}

struct DirectionalEasingModifier: ViewModifier {
    let progress: Double
    let direction: CGPoint
    let scale: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directionalEasing(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(scale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DirectionalEasingTransition {
    static func directionalEasing(
        direction: CGPoint = CGPoint(x: 1, y: 0),
        scale: Double = 0.5
    ) -> Self {
        DirectionalEasingTransition(
            direction: direction,
            scale: scale
        )
    }
}

public struct DirectionalEasingTransition: Transition {
    let direction: CGPoint
    let scale: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directionalEasing(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(scale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
