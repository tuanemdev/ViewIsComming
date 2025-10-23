import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a spinning effect.
    ///
    /// - Parameters:
    ///   - rotations: Number of rotations (0.5 to 10.0). Default is 3.0.
    ///   - zoom: Zoom amount during spin (0.0 to 2.0). Default is 0.5.
    /// - Returns: A transition that creates a spinning effect.
    static func spin(
        rotations: Double = 3.0,
        zoom: Double = 0.5
    ) -> AnyTransition {
        .modifier(
            active: SpinModifier(
                progress: 0,
                rotations: rotations,
                zoom: zoom
            ),
            identity: SpinModifier(
                progress: 1,
                rotations: rotations,
                zoom: zoom
            )
        )
    }
}

struct SpinModifier: ViewModifier {
    let progress: Double
    let rotations: Double
    let zoom: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.spin(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(rotations),
                            .float(zoom)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == SpinTransition {
    /// A transition that creates a spinning effect.
    ///
    /// - Parameters:
    ///   - rotations: Number of rotations (0.5 to 10.0). Default is 3.0.
    ///   - zoom: Zoom amount during spin (0.0 to 2.0). Default is 0.5.
    /// - Returns: A transition that creates a spinning effect.
    static func spin(
        rotations: Double = 3.0,
        zoom: Double = 0.5
    ) -> Self {
        SpinTransition(
            rotations: rotations,
            zoom: zoom
        )
    }
}

public struct SpinTransition: Transition {
    let rotations: Double
    let zoom: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.spin(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(rotations),
                            .float(zoom)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
