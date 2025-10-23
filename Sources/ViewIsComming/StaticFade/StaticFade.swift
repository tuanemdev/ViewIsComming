import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func staticFade(
        nNoisePixels: Double = 200.0,
        staticLuminosity: Double = 0.8
    ) -> AnyTransition {
        .modifier(
            active: StaticFadeModifier(
                progress: 0,
                nNoisePixels: nNoisePixels,
                staticLuminosity: staticLuminosity
            ),
            identity: StaticFadeModifier(
                progress: 1,
                nNoisePixels: nNoisePixels,
                staticLuminosity: staticLuminosity
            )
        )
    }
}

struct StaticFadeModifier: ViewModifier {
    let progress: Double
    let nNoisePixels: Double
    let staticLuminosity: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.staticFade(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(nNoisePixels),
                            .float(staticLuminosity)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == StaticFadeTransition {
    static func staticFade(
        nNoisePixels: Double = 200.0,
        staticLuminosity: Double = 0.8
    ) -> Self {
        StaticFadeTransition(
            nNoisePixels: nNoisePixels,
            staticLuminosity: staticLuminosity
        )
    }
}

public struct StaticFadeTransition: Transition {
    let nNoisePixels: Double
    let staticLuminosity: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.staticFade(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(nNoisePixels),
                            .float(staticLuminosity)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
