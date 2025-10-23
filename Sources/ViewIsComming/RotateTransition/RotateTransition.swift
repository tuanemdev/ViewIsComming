import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static var rotateTransition: AnyTransition {
        .modifier(
            active: RotateTransitionModifier(progress: 0),
            identity: RotateTransitionModifier(progress: 1)
        )
    }
}

struct RotateTransitionModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.rotateTransition(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == RotateTransitionTransition {
    static var rotateTransition: Self {
        RotateTransitionTransition()
    }
}

public struct RotateTransitionTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.rotateTransition(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
