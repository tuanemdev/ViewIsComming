import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func luma(
        patternScale: Double = 3.0
    ) -> AnyTransition {
        .modifier(
            active: LumaModifier(
                progress: 0,
                patternScale: patternScale
            ),
            identity: LumaModifier(
                progress: 1,
                patternScale: patternScale
            )
        )
    }
}

struct LumaModifier: ViewModifier {
    let progress: Double
    let patternScale: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.luma(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(patternScale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == LumaTransition {
    static func luma(
        patternScale: Double = 3.0
    ) -> Self {
        LumaTransition(patternScale: patternScale)
    }
}

public struct LumaTransition: Transition {
    let patternScale: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.luma(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(patternScale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
