import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    /// Burn transition with color glow effect
    /// - Parameter color: The burn color (default: orange/red)
    static func burn(color: Color = Color(red: 0.9, green: 0.4, blue: 0.2)) -> AnyTransition {
        .modifier(
            active: BurnModifier(progress: 0, color: color),
            identity: BurnModifier(progress: 1, color: color)
        )
    }
}

struct BurnModifier: ViewModifier {
    let progress: Double
    let color: Color
    
    func body(content: Content) -> some View {
        let resolved = color.resolve(in: EnvironmentValues())
        return content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.burn(
                    .float2(geometryProxy.size),
                    .float(progress),
                    .float3(Float(resolved.red), Float(resolved.green), Float(resolved.blue))
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

// MARK: - Transition
public extension Transition where Self == BurnTransition {
    /// Burn transition with color glow effect
    /// - Parameter color: The burn color (default: orange/red)
    static func burn(color: Color = Color(red: 0.9, green: 0.4, blue: 0.2)) -> Self {
        BurnTransition(color: color)
    }
}

public struct BurnTransition: Transition {
    let color: Color
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        let resolved = color.resolve(in: EnvironmentValues())
        return content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.burn(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0),
                    .float3(Float(resolved.red), Float(resolved.green), Float(resolved.blue))
                ),
                maxSampleOffset: .zero
            )
        }
    }
}
