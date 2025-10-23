import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a stereo viewer effect.
    ///
    /// - Parameters:
    ///   - zoom: Zoom amount (0.0 to 1.0). Default is 0.5.
    ///   - cornerRadius: Corner radius (0.0 to 0.5). Default is 0.1.
    /// - Returns: A transition that creates a stereo viewer effect.
    static func stereoViewer(
        zoom: Double = 0.5,
        cornerRadius: Double = 0.1
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

// MARK: - Transition (iOS 17+)
public extension Transition where Self == StereoViewerTransition {
    /// A transition that creates a stereo viewer effect.
    ///
    /// - Parameters:
    ///   - zoom: Zoom amount (0.0 to 1.0). Default is 0.5.
    ///   - cornerRadius: Corner radius (0.0 to 0.5). Default is 0.1.
    /// - Returns: A transition that creates a stereo viewer effect.
    static func stereoViewer(
        zoom: Double = 0.5,
        cornerRadius: Double = 0.1
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
