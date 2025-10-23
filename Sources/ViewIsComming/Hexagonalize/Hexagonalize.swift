import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func hexagonalize(
        steps: Double = 50,
        horizontalHexagons: Double = 20
    ) -> AnyTransition {
        .modifier(
            active: HexagonalizeModifier(
                progress: 0,
                steps: steps,
                horizontalHexagons: horizontalHexagons
            ),
            identity: HexagonalizeModifier(
                progress: 1,
                steps: steps,
                horizontalHexagons: horizontalHexagons
            )
        )
    }
}

struct HexagonalizeModifier: ViewModifier {
    let progress: Double
    let steps: Double
    let horizontalHexagons: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.hexagonalize(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(steps),
                            .float(horizontalHexagons)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == HexagonalizeTransition {
    static func hexagonalize(
        steps: Double = 50,
        horizontalHexagons: Double = 20
    ) -> Self {
        HexagonalizeTransition(
            steps: steps,
            horizontalHexagons: horizontalHexagons
        )
    }
}

public struct HexagonalizeTransition: Transition {
    let steps: Double
    let horizontalHexagons: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.hexagonalize(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(steps),
                            .float(horizontalHexagons)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
