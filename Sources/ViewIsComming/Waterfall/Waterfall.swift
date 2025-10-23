import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a waterfall flowing effect.
    ///
    /// - Parameters:
    ///   - speed: Flow speed (0.1 to 5.0). Default is 2.0.
    ///   - amplitude: Wave amplitude (0.0 to 0.5). Default is 0.1.
    /// - Returns: A transition that creates a waterfall effect.
    static func waterfall(
        speed: Double = 2.0,
        amplitude: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: WaterfallModifier(
                progress: 0,
                speed: speed,
                amplitude: amplitude
            ),
            identity: WaterfallModifier(
                progress: 1,
                speed: speed,
                amplitude: amplitude
            )
        )
    }
}

struct WaterfallModifier: ViewModifier {
    let progress: Double
    let speed: Double
    let amplitude: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.waterfall(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(speed),
                            .float(amplitude)
                        ),
                        maxSampleOffset: CGSize(width: 0, height: 50)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == WaterfallTransition {
    /// A transition that creates a waterfall flowing effect.
    ///
    /// - Parameters:
    ///   - speed: Flow speed (0.1 to 5.0). Default is 2.0.
    ///   - amplitude: Wave amplitude (0.0 to 0.5). Default is 0.1.
    /// - Returns: A transition that creates a waterfall effect.
    static func waterfall(
        speed: Double = 2.0,
        amplitude: Double = 0.1
    ) -> Self {
        WaterfallTransition(
            speed: speed,
            amplitude: amplitude
        )
    }
}

public struct WaterfallTransition: Transition {
    let speed: Double
    let amplitude: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.waterfall(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(speed),
                            .float(amplitude)
                        ),
                        maxSampleOffset: CGSize(width: 0, height: 50)
                    )
            }
    }
}
