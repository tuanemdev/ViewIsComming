import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func radialBlur(
        samples: Double = 10.0
    ) -> AnyTransition {
        .modifier(
            active: RadialBlurModifier(
                progress: 0,
                samples: samples
            ),
            identity: RadialBlurModifier(
                progress: 1,
                samples: samples
            )
        )
    }
}

struct RadialBlurModifier: ViewModifier {
    let progress: Double
    let samples: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.radialBlur(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(samples)
                        ),
                        maxSampleOffset: CGSize(width: 50, height: 50)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == RadialBlurTransition {
    static func radialBlur(
        samples: Double = 10.0
    ) -> Self {
        RadialBlurTransition(samples: samples)
    }
}

public struct RadialBlurTransition: Transition {
    let samples: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.radialBlur(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(samples)
                        ),
                        maxSampleOffset: CGSize(width: 50, height: 50)
                    )
            }
    }
}
