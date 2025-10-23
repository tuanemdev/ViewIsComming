import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func overexposure(
        strength: Double = 2.0
    ) -> AnyTransition {
        .modifier(
            active: OverexposureModifier(
                progress: 0,
                strength: strength
            ),
            identity: OverexposureModifier(
                progress: 1,
                strength: strength
            )
        )
    }
}

struct OverexposureModifier: ViewModifier {
    let progress: Double
    let strength: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.overexposure(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(strength)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == OverexposureTransition {
    static func overexposure(
        strength: Double = 2.0
    ) -> Self {
        OverexposureTransition(strength: strength)
    }
}

public struct OverexposureTransition: Transition {
    let strength: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.overexposure(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(strength)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
