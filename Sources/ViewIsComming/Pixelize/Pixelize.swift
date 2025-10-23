import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that pixelates the content with increasing then decreasing pixel size
    /// - Parameters:
    ///   - squaresMin: Minimum number of squares/pixels (default: 2.0)
    ///   - steps: Number of discrete steps in the animation (default: 20.0, use -1.0 for smooth)
    /// - Returns: A custom transition with pixelization effect
    static func pixelize(
        squaresMin: Double = 2.0,
        steps: Double = 20.0
    ) -> AnyTransition {
        .modifier(
            active: PixelizeModifier(
                progress: 0,
                squaresMin: squaresMin,
                steps: steps
            ),
            identity: PixelizeModifier(
                progress: 1,
                squaresMin: squaresMin,
                steps: steps
            )
        )
    }
}

struct PixelizeModifier: ViewModifier {
    let progress: Double
    let squaresMin: Double
    let steps: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.pixelize(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(squaresMin),
                            .float(steps)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == PixelizeTransition {
    /// A transition that pixelates the content with increasing then decreasing pixel size
    /// - Parameters:
    ///   - squaresMin: Minimum number of squares/pixels (default: 2.0)
    ///   - steps: Number of discrete steps in the animation (default: 20.0, use -1.0 for smooth)
    /// - Returns: A custom transition with pixelization effect
    static func pixelize(
        squaresMin: Double = 2.0,
        steps: Double = 20.0
    ) -> Self {
        PixelizeTransition(
            squaresMin: squaresMin,
            steps: steps
        )
    }
}

public struct PixelizeTransition: Transition {
    let squaresMin: Double
    let steps: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.pixelize(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(squaresMin),
                            .float(steps)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
