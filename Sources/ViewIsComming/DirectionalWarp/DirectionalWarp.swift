import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func directionalWarp(
        direction: CGPoint = CGPoint(x: -1.0, y: 1.0),
        smoothness: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: DirectionalWarpModifier(
                progress: 0,
                direction: direction,
                smoothness: smoothness
            ),
            identity: DirectionalWarpModifier(
                progress: 1,
                direction: direction,
                smoothness: smoothness
            )
        )
    }
}

struct DirectionalWarpModifier: ViewModifier {
    let progress: Double
    let direction: CGPoint
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directionalWarp(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: CGSize(
                            width: geometryProxy.size.width * smoothness,
                            height: geometryProxy.size.height * smoothness
                        )
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DirectionalWarpTransition {
    static func directionalWarp(
        direction: CGPoint = CGPoint(x: -1.0, y: 1.0),
        smoothness: Double = 0.1
    ) -> Self {
        DirectionalWarpTransition(
            direction: direction,
            smoothness: smoothness
        )
    }
}

public struct DirectionalWarpTransition: Transition {
    let direction: CGPoint
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.directionalWarp(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(direction.x), Float(direction.y)),
                            .float(smoothness)
                        ),
                        maxSampleOffset: CGSize(
                            width: geometryProxy.size.width * smoothness,
                            height: geometryProxy.size.height * smoothness
                        )
                    )
            }
    }
}
