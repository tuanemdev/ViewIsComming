import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func stereoViewer(
        zoom: Double = 0.88,
        cornerRadius: Double = 0.22
    ) -> AnyTransition {
        .modifier(
            active: StereoViewerModifier(
                progress: 0,
                zoom: zoom,
                cornerRadius: cornerRadius
            ),
            identity: StereoViewerModifier(
                progress: 1,
                zoom: zoom,
                cornerRadius: cornerRadius
            )
        )
    }
}

struct StereoViewerModifier: ViewModifier {
    let progress: Double
    let zoom: Double
    let cornerRadius: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.stereoViewer(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(zoom),
                            .float(cornerRadius)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == StereoViewerTransition {
    static func stereoViewer(
        zoom: Double = 0.88,
        cornerRadius: Double = 0.22
    ) -> Self {
        StereoViewerTransition(
            zoom: zoom,
            cornerRadius: cornerRadius
        )
    }
}

public struct StereoViewerTransition: Transition {
    let zoom: Double
    let cornerRadius: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.stereoViewer(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(zoom),
                            .float(cornerRadius)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
