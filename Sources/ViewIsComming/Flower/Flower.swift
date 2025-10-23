import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a flower-shaped reveal effect.
    ///
    /// - Parameters:
    ///   - petals: Number of petals (3.0 to 12.0). Default is 6.0.
    ///   - petalSize: Petal depth (0.0 to 0.5). Default is 0.2.
    /// - Returns: A transition that creates a flower reveal effect.
    static func flower(
        petals: Double = 6.0,
        petalSize: Double = 0.2
    ) -> AnyTransition {
        .modifier(
            active: FlowerModifier(
                progress: 0,
                petals: petals,
                petalSize: petalSize
            ),
            identity: FlowerModifier(
                progress: 1,
                petals: petals,
                petalSize: petalSize
            )
        )
    }
}

struct FlowerModifier: ViewModifier {
    let progress: Double
    let petals: Double
    let petalSize: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.flower(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(petals),
                            .float(petalSize)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == FlowerTransition {
    /// A transition that creates a flower-shaped reveal effect.
    ///
    /// - Parameters:
    ///   - petals: Number of petals (3.0 to 12.0). Default is 6.0.
    ///   - petalSize: Petal depth (0.0 to 0.5). Default is 0.2.
    /// - Returns: A transition that creates a flower reveal effect.
    static func flower(
        petals: Double = 6.0,
        petalSize: Double = 0.2
    ) -> Self {
        FlowerTransition(
            petals: petals,
            petalSize: petalSize
        )
    }
}

public struct FlowerTransition: Transition {
    let petals: Double
    let petalSize: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.flower(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(petals),
                            .float(petalSize)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
