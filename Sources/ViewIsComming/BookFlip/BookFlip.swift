import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static var bookFlip: AnyTransition {
        .modifier(
            active: BookFlipModifier(progress: 0),
            identity: BookFlipModifier(progress: 1)
        )
    }
}

struct BookFlipModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.bookFlip(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == BookFlipTransition {
    static var bookFlip: Self {
        BookFlipTransition()
    }
}

public struct BookFlipTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.bookFlip(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
