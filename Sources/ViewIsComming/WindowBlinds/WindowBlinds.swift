import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static var windowBlinds: AnyTransition {
        .modifier(
            active: WindowBlindsModifier(progress: 0),
            identity: WindowBlindsModifier(progress: 1)
        )
    }
}

struct WindowBlindsModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.windowBlinds(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == WindowBlindsTransition {
    static var windowBlinds: Self {
        WindowBlindsTransition()
    }
}

public struct WindowBlindsTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.windowBlinds(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
