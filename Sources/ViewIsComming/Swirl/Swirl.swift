import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a swirling rotation effect from the center
    /// - Returns: A custom transition with swirl distortion
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
                        maxSampleOffset: CGSize(width: 50, height: 50)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == SwirlTransition {
    /// A transition that creates a swirling rotation effect from the center
    /// - Returns: A custom transition with swirl distortion
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
                        maxSampleOffset: CGSize(width: 50, height: 50)
                    )
            }
    }
}
