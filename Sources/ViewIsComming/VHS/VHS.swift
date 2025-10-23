import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a VHS tape glitch effect.
    ///
    /// - Parameters:
    ///   - glitchAmount: Glitch intensity (0.0 to 1.0). Default is 0.5.
    ///   - lineHeight: Scanline height (0.001 to 0.05). Default is 0.005.
    /// - Returns: A transition that creates a VHS effect.
    static func vhs(
        glitchAmount: Double = 0.5,
        lineHeight: Double = 0.005
    ) -> AnyTransition {
        .modifier(
            active: VHSModifier(
                progress: 0,
                glitchAmount: glitchAmount,
                lineHeight: lineHeight
            ),
            identity: VHSModifier(
                progress: 1,
                glitchAmount: glitchAmount,
                lineHeight: lineHeight
            )
        )
    }
}

struct VHSModifier: ViewModifier {
    let progress: Double
    let glitchAmount: Double
    let lineHeight: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.vhs(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(glitchAmount),
                            .float(lineHeight)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 0)
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == VHSTransition {
    /// A transition that creates a VHS tape glitch effect.
    ///
    /// - Parameters:
    ///   - glitchAmount: Glitch intensity (0.0 to 1.0). Default is 0.5.
    ///   - lineHeight: Scanline height (0.001 to 0.05). Default is 0.005.
    /// - Returns: A transition that creates a VHS effect.
    static func vhs(
        glitchAmount: Double = 0.5,
        lineHeight: Double = 0.005
    ) -> Self {
        VHSTransition(
            glitchAmount: glitchAmount,
            lineHeight: lineHeight
        )
    }
}

public struct VHSTransition: Transition {
    let glitchAmount: Double
    let lineHeight: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.vhs(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(glitchAmount),
                            .float(lineHeight)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 0)
                    )
            }
    }
}
