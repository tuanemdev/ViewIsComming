import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that reveals content through an expanding heart shape
    /// - Returns: A custom transition with heart shape reveal
    static var heart: AnyTransition {
        .modifier(
            active: HeartModifier(progress: 0),
            identity: HeartModifier(progress: 1)
        )
    }
}

struct HeartModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.heart(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == HeartTransition {
    /// A transition that reveals content through an expanding heart shape
    /// - Returns: A custom transition with heart shape reveal
    static var heart: Self {
        HeartTransition()
    }
}

public struct HeartTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.heart(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
