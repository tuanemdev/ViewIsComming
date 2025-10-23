import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that applies a horizontal linear blur that peaks in the middle
    /// - Parameter intensity: The maximum blur amount (default: 0.1)
    /// - Returns: A custom transition with linear blur effect
    static func linearBlur(
        intensity: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: LinearBlurModifier(
                progress: 0,
                intensity: intensity
            ),
            identity: LinearBlurModifier(
                progress: 1,
                intensity: intensity
            )
        )
    }
}

struct LinearBlurModifier: ViewModifier {
    let progress: Double
    let intensity: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.linearBlur(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(intensity)
                        ),
                        maxSampleOffset: CGSize(width: 50, height: 0)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == LinearBlurTransition {
    /// A transition that applies a horizontal linear blur that peaks in the middle
    /// - Parameter intensity: The maximum blur amount (default: 0.1)
    /// - Returns: A custom transition with linear blur effect
    static func linearBlur(
        intensity: Double = 0.1
    ) -> Self {
        LinearBlurTransition(intensity: intensity)
    }
}

public struct LinearBlurTransition: Transition {
    let intensity: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.linearBlur(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(intensity)
                        ),
                        maxSampleOffset: CGSize(width: 50, height: 0)
                    )
            }
    }
}
