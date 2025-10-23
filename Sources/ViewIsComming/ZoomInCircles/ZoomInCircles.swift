import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a zoom in circles pattern effect.
    ///
    /// - Parameters:
    ///   - speed: Zoom speed (0.1 to 3.0). Default is 1.5.
    ///   - density: Circle density (1.0 to 20.0). Default is 10.0.
    /// - Returns: A transition that creates a zoom in circles effect.
    static func zoomInCircles(
        speed: Double = 1.5,
        density: Double = 10.0
    ) -> AnyTransition {
        .modifier(
            active: ZoomInCirclesModifier(
                progress: 0,
                speed: speed,
                density: density
            ),
            identity: ZoomInCirclesModifier(
                progress: 1,
                speed: speed,
                density: density
            )
        )
    }
}

struct ZoomInCirclesModifier: ViewModifier {
    let progress: Double
    let speed: Double
    let density: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.zoomInCircles(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(speed),
                            .float(density)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == ZoomInCirclesTransition {
    /// A transition that creates a zoom in circles pattern effect.
    ///
    /// - Parameters:
    ///   - speed: Zoom speed (0.1 to 3.0). Default is 1.5.
    ///   - density: Circle density (1.0 to 20.0). Default is 10.0.
    /// - Returns: A transition that creates a zoom in circles effect.
    static func zoomInCircles(
        speed: Double = 1.5,
        density: Double = 10.0
    ) -> Self {
        ZoomInCirclesTransition(
            speed: speed,
            density: density
        )
    }
}

public struct ZoomInCirclesTransition: Transition {
    let speed: Double
    let density: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.zoomInCircles(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(speed),
                            .float(density)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
