import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// Radial wipe transition based on angle
    /// - Parameter smoothness: Controls the edge smoothness of the wipe (default: 1.0)
    static func radial(smoothness: Double = 1.0) -> AnyTransition {
        .modifier(
            active: RadialModifier(progress: 0, smoothness: smoothness),
            identity: RadialModifier(progress: 1, smoothness: smoothness)
        )
    }
}

struct RadialModifier: ViewModifier {
    let progress: Double
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.radial(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == RadialTransition {
    /// Radial wipe transition based on angle
    /// - Parameter smoothness: Controls the edge smoothness of the wipe (default: 1.0)
    static func radial(smoothness: Double = 1.0) -> Self {
        RadialTransition(smoothness: smoothness)
    }
}

public struct RadialTransition: Transition {
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.radial(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
