import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a dreamy, blurred effect that peaks in the middle
    /// - Returns: A custom transition with dreamy blur distortion
    static var dreamy: AnyTransition {
        .modifier(
            active: DreamyModifier(progress: 0),
            identity: DreamyModifier(progress: 1)
        )
    }
}

struct DreamyModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.dreamy(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: CGSize(width: 15, height: 15)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DreamyTransition {
    /// A transition that creates a dreamy, blurred effect that peaks in the middle
    /// - Returns: A custom transition with dreamy blur distortion
    static var dreamy: Self {
        DreamyTransition()
    }
}

public struct DreamyTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.dreamy(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: CGSize(width: 15, height: 15)
                    )
            }
    }
}
