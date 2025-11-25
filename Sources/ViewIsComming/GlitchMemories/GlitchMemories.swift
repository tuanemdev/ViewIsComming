import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static var glitchMemories: AnyTransition {
        .modifier(
            active: GlitchMemoriesModifier(progress: 0),
            identity: GlitchMemoriesModifier(progress: 1)
        )
    }
}

struct GlitchMemoriesModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.glitchMemories(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == GlitchMemoriesTransition {
    static var glitchMemories: Self {
        GlitchMemoriesTransition()
    }
}

public struct GlitchMemoriesTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.glitchMemories(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
