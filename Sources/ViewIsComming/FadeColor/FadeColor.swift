import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    /// Fade through a specific color
    /// - Parameters:
    ///   - color: The intermediate color to fade through (default: black)
    ///   - colorPhase: How prominent the color phase is, 0.0 to 1.0 (default: 0.4)
    static func fadeColor(
        color: Color = .black,
        colorPhase: Double = 0.4
    ) -> AnyTransition {
        .modifier(
            active: FadeColorModifier(progress: 0, color: color, colorPhase: colorPhase),
            identity: FadeColorModifier(progress: 1, color: color, colorPhase: colorPhase)
        )
    }
}

struct FadeColorModifier: ViewModifier {
    let progress: Double
    let color: Color
    let colorPhase: Double
    
    func body(content: Content) -> some View {
        let resolved = color.resolve(in: EnvironmentValues())
        return content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.fadeColor(
                    .float2(geometryProxy.size),
                    .float(progress),
                    .float3(Float(resolved.red), Float(resolved.green), Float(resolved.blue)),
                    .float(colorPhase)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

// MARK: - Transition
public extension Transition where Self == FadeColorTransition {
    /// Fade through a specific color
    /// - Parameters:
    ///   - color: The intermediate color to fade through (default: black)
    ///   - colorPhase: How prominent the color phase is, 0.0 to 1.0 (default: 0.4)
    static func fadeColor(
        color: Color = .black,
        colorPhase: Double = 0.4
    ) -> Self {
        FadeColorTransition(color: color, colorPhase: colorPhase)
    }
}

public struct FadeColorTransition: Transition {
    let color: Color
    let colorPhase: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        let resolved = color.resolve(in: EnvironmentValues())
        return content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.fadeColor(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0),
                    .float3(Float(resolved.red), Float(resolved.green), Float(resolved.blue)),
                    .float(colorPhase)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}
