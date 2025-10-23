import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func zoomBlur(
        strength: Double = 0.3,
        samples: Double = 10.0
    ) -> AnyTransition {
        .modifier(
            active: ZoomBlurModifier(
                progress: 0,
                strength: strength,
                samples: samples
            ),
            identity: ZoomBlurModifier(
                progress: 1,
                strength: strength,
                samples: samples
            )
        )
    }
}

struct ZoomBlurModifier: ViewModifier {
    let progress: Double
    let strength: Double
    let samples: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.zoomBlur(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(strength),
                            .float(samples)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == ZoomBlurTransition {
    static func zoomBlur(
        strength: Double = 0.3,
        samples: Double = 10.0
    ) -> Self {
        ZoomBlurTransition(
            strength: strength,
            samples: samples
        )
    }
}

public struct ZoomBlurTransition: Transition {
    let strength: Double
    let samples: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.zoomBlur(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(strength),
                            .float(samples)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
    }
}
