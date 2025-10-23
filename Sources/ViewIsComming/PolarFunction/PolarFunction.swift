import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func polarFunction(
        segments: Double = 5.0
    ) -> AnyTransition {
        .modifier(
            active: PolarFunctionModifier(
                progress: 0,
                segments: segments
            ),
            identity: PolarFunctionModifier(
                progress: 1,
                segments: segments
            )
        )
    }
}

struct PolarFunctionModifier: ViewModifier {
    let progress: Double
    let segments: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.polarFunction(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(segments)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == PolarFunctionTransition {
    static func polarFunction(
        segments: Double = 5.0
    ) -> Self {
        PolarFunctionTransition(segments: segments)
    }
}

public struct PolarFunctionTransition: Transition {
    let segments: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.polarFunction(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(segments)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
