import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    /// Circle crop transition that reveals/hides content in a circular pattern
    /// - Parameter backgroundColor: Background color shown during transition (default: black)
    static func circleCrop(backgroundColor: Color = .black) -> AnyTransition {
        .modifier(
            active: CircleCropModifier(progress: 0, backgroundColor: backgroundColor),
            identity: CircleCropModifier(progress: 1, backgroundColor: backgroundColor)
        )
    }
}

struct CircleCropModifier: ViewModifier {
    let progress: Double
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        let resolved = backgroundColor.resolve(in: EnvironmentValues())
        return content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.circleCrop(
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
public extension Transition where Self == CircleCropTransition {
    /// Circle crop transition that reveals/hides content in a circular pattern
    /// - Parameter backgroundColor: Background color shown during transition (default: black)
    static func circleCrop(backgroundColor: Color = .black) -> Self {
        CircleCropTransition(backgroundColor: backgroundColor)
    }
}

public struct CircleCropTransition: Transition {
    let backgroundColor: Color
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        let resolved = backgroundColor.resolve(in: EnvironmentValues())
        return content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.circleCrop(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0),
                    .float3(Float(resolved.red), Float(resolved.green), Float(resolved.blue))
                ),
                maxSampleOffset: .zero
            )
        }
    }
}
