import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    /// Wind transition with random horizontal displacement
    /// - Parameter size: Controls the wind effect size (default: 0.2)
    static func wind(size: Double = 0.2) -> AnyTransition {
        .modifier(
            active: WindModifier(progress: 0, size: size),
            identity: WindModifier(progress: 1, size: size)
        )
    }
}

struct WindModifier: ViewModifier {
    let progress: Double
    let size: Double
    
    func body(content: Content) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wind(
                    .float2(geometryProxy.size),
                    .float(progress),
                    .float(size)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

// MARK: - Transition
public extension Transition where Self == WindTransition {
    /// Wind transition with random horizontal displacement
    /// - Parameter size: Controls the wind effect size (default: 0.2)
    static func wind(size: Double = 0.2) -> Self {
        WindTransition(size: size)
    }
}

public struct WindTransition: Transition {
    let size: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wind(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0),
                    .float(size)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}
