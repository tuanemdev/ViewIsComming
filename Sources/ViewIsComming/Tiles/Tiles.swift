import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a tile-based reveal effect.
    ///
    /// - Parameters:
    ///   - tilesX: Number of tiles horizontally (2 to 20). Default is 10.
    ///   - tilesY: Number of tiles vertically (2 to 20). Default is 10.
    /// - Returns: A transition that creates a tiles effect.
    static func tiles(
        tilesX: Double = 10.0,
        tilesY: Double = 10.0
    ) -> AnyTransition {
        .modifier(
            active: TilesModifier(
                progress: 0,
                tilesX: tilesX,
                tilesY: tilesY
            ),
            identity: TilesModifier(
                progress: 1,
                tilesX: tilesX,
                tilesY: tilesY
            )
        )
    }
}

struct TilesModifier: ViewModifier {
    let progress: Double
    let tilesX: Double
    let tilesY: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.tiles(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(tilesX),
                            .float(tilesY)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == TilesTransition {
    /// A transition that creates a tile-based reveal effect.
    ///
    /// - Parameters:
    ///   - tilesX: Number of tiles horizontally (2 to 20). Default is 10.
    ///   - tilesY: Number of tiles vertically (2 to 20). Default is 10.
    /// - Returns: A transition that creates a tiles effect.
    static func tiles(
        tilesX: Double = 10.0,
        tilesY: Double = 10.0
    ) -> Self {
        TilesTransition(
            tilesX: tilesX,
            tilesY: tilesY
        )
    }
}

public struct TilesTransition: Transition {
    let tilesX: Double
    let tilesY: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.tiles(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(tilesX),
                            .float(tilesY)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
