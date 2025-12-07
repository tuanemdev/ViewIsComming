import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static var swirl: AnyTransition {
        .modifier(
            active: SwirlModifier(progress: 0),
            identity: SwirlModifier(progress: 1)
        )
    }
}

struct SwirlModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.swirl(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == SwirlTransition {
    static var swirl: Self {
        SwirlTransition()
    }
}

public struct SwirlTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.swirl(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
