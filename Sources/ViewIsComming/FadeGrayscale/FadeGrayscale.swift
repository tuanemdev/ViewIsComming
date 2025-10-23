import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func fadeGrayscale(
        intensity: Double = 0.3
    ) -> AnyTransition {
        .modifier(
            active: FadeGrayscaleModifier(
                progress: 0,
                intensity: intensity
            ),
            identity: FadeGrayscaleModifier(
                progress: 1,
                intensity: intensity
            )
        )
    }
}

struct FadeGrayscaleModifier: ViewModifier {
    let progress: Double
    let intensity: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.fadeGrayscale(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(intensity)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == FadeGrayscaleTransition {
    static func fadeGrayscale(
        intensity: Double = 0.3
    ) -> Self {
        FadeGrayscaleTransition(intensity: intensity)
    }
}

public struct FadeGrayscaleTransition: Transition {
    let intensity: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.fadeGrayscale(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(intensity)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
