import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func swap(
        reflection: Double = 0.4,
        perspective: Double = 0.2,
        depth: Double = 3.0,
        swapRight: Bool = true
    ) -> AnyTransition {
        .modifier(
            active: SwapModifier(
                progress: 0,
                reflection: reflection,
                perspective: perspective,
                depth: depth,
                swapRight: swapRight
            ),
            identity: SwapModifier(
                progress: 1,
                reflection: reflection,
                perspective: perspective,
                depth: depth,
                swapRight: swapRight
            )
        )
    }
}

struct SwapModifier: ViewModifier {
    let progress: Double
    let reflection: Double
    let perspective: Double
    let depth: Double
    let swapRight: Bool
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.swap(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(reflection),
                            .float(perspective),
                            .float(depth),
                            .float(swapRight ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == SwapTransition {
    static func swap(
        reflection: Double = 0.4,
        perspective: Double = 0.2,
        depth: Double = 3.0,
        swapRight: Bool = true
    ) -> Self {
        SwapTransition(
            reflection: reflection,
            perspective: perspective,
            depth: depth,
            swapRight: swapRight
        )
    }
}

public struct SwapTransition: Transition {
    let reflection: Double
    let perspective: Double
    let depth: Double
    let swapRight: Bool
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.swap(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(reflection),
                            .float(perspective),
                            .float(depth),
                            .float(swapRight ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
