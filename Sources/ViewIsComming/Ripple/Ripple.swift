import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    /// Ripple distortion transition emanating from center
    /// - Parameters:
    ///   - amplitude: Wave amplitude (default: 100.0)
    ///   - speed: Wave speed (default: 50.0)
    static func ripple(amplitude: Double = 100.0, speed: Double = 50.0) -> AnyTransition {
        .modifier(
            active: RippleModifier(progress: 0, amplitude: amplitude, speed: speed),
            identity: RippleModifier(progress: 1, amplitude: amplitude, speed: speed)
        )
    }
}

struct RippleModifier: ViewModifier {
    let progress: Double
    let amplitude: Double
    let speed: Double
    
    func body(content: Content) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.ripple(
                    .float2(geometryProxy.size),
                    .float(progress),
                    .float(amplitude),
                    .float(speed)
                ),
                maxSampleOffset: CGSize(width: 10, height: 10)
            )
        }
    }
}

// MARK: - Transition
public extension Transition where Self == RippleTransition {
    /// Ripple distortion transition emanating from center
    /// - Parameters:
    ///   - amplitude: Wave amplitude (default: 100.0)
    ///   - speed: Wave speed (default: 50.0)
    static func ripple(amplitude: Double = 100.0, speed: Double = 50.0) -> Self {
        RippleTransition(amplitude: amplitude, speed: speed)
    }
}

public struct RippleTransition: Transition {
    let amplitude: Double
    let speed: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.ripple(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0),
                    .float(amplitude),
                    .float(speed)
                ),
                maxSampleOffset: CGSize(width: 10, height: 10)
            )
        }
    }
}
