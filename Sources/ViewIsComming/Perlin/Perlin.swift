import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func perlin(
        scale: Double = 4.0,
        smoothness: Double = 0.01,
        seed: Double = 12.9898
    ) -> AnyTransition {
        .modifier(
            active: PerlinModifier(
                progress: 0,
                scale: scale,
                smoothness: smoothness,
                seed: seed
            ),
            identity: PerlinModifier(
                progress: 1,
                scale: scale,
                smoothness: smoothness,
                seed: seed
            )
        )
    }
}

struct PerlinModifier: ViewModifier {
    let progress: Double
    let scale: Double
    let smoothness: Double
    let seed: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.perlin(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(scale),
                            .float(smoothness),
                            .float(seed)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == PerlinTransition {
    static func perlin(
        scale: Double = 4.0,
        smoothness: Double = 0.01,
        seed: Double = 12.9898
    ) -> Self {
        PerlinTransition(
            scale: scale,
            smoothness: smoothness,
            seed: seed
        )
    }
}

public struct PerlinTransition: Transition {
    let scale: Double
    let smoothness: Double
    let seed: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.perlin(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(scale),
                            .float(smoothness),
                            .float(seed)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
