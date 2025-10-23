import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that vanishes from a corner.
    ///
    /// - Parameters:
    ///   - cornerSize: Edge smoothness (0.0 to 1.0). Default is 0.3.
    ///   - corner: Corner to vanish from (0=TL, 1=TR, 2=BR, 3=BL). Default is 0.
    /// - Returns: A transition that vanishes from a corner.
    static func cornerVanish(
        cornerSize: Double = 0.3,
        corner: Int = 0
    ) -> AnyTransition {
        .modifier(
            active: CornerVanishModifier(
                progress: 0,
                cornerSize: cornerSize,
                corner: corner
            ),
            identity: CornerVanishModifier(
                progress: 1,
                cornerSize: cornerSize,
                corner: corner
            )
        )
    }
}

struct CornerVanishModifier: ViewModifier {
    let progress: Double
    let cornerSize: Double
    let corner: Int
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.cornerVanish(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(cornerSize),
                            .float(Float(corner))
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == CornerVanishTransition {
    /// A transition that vanishes from a corner.
    ///
    /// - Parameters:
    ///   - cornerSize: Edge smoothness (0.0 to 1.0). Default is 0.3.
    ///   - corner: Corner to vanish from (0=TL, 1=TR, 2=BR, 3=BL). Default is 0.
    /// - Returns: A transition that vanishes from a corner.
    static func cornerVanish(
        cornerSize: Double = 0.3,
        corner: Int = 0
    ) -> Self {
        CornerVanishTransition(
            cornerSize: cornerSize,
            corner: corner
        )
    }
}

public struct CornerVanishTransition: Transition {
    let cornerSize: Double
    let corner: Int
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.cornerVanish(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(cornerSize),
                            .float(Float(corner))
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
