import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func dreamyZoom(
        rotation: Double = 0.0,
        scale: Double = 2.0
    ) -> AnyTransition {
        .modifier(
            active: DreamyZoomModifier(
                progress: 0,
                rotation: rotation,
                scale: scale
            ),
            identity: DreamyZoomModifier(
                progress: 1,
                rotation: rotation,
                scale: scale
            )
        )
    }
}

struct DreamyZoomModifier: ViewModifier {
    let progress: Double
    let rotation: Double
    let scale: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.dreamyZoom(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(rotation),
                            .float(scale)
                        ),
                        maxSampleOffset: CGSize(width: 20, height: 20)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DreamyZoomTransition {
    static func dreamyZoom(
        rotation: Double = 0.0,
        scale: Double = 2.0
    ) -> Self {
        DreamyZoomTransition(
            rotation: rotation,
            scale: scale
        )
    }
}

public struct DreamyZoomTransition: Transition {
    let rotation: Double
    let scale: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.dreamyZoom(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(rotation),
                            .float(scale)
                        ),
                        maxSampleOffset: CGSize(width: 20, height: 20)
                    )
            }
    }
}
