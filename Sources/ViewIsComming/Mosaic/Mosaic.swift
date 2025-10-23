import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that breaks the image into mosaic tiles that disappear randomly
    /// - Parameters:
    ///   - endX: Number of horizontal tiles (default: 10)
    ///   - endY: Number of vertical tiles (default: 10)
    /// - Returns: A custom transition with mosaic effect
    static func mosaic(
        endX: Int = 10,
        endY: Int = 10
    ) -> AnyTransition {
        .modifier(
            active: MosaicModifier(
                progress: 0,
                endX: endX,
                endY: endY
            ),
            identity: MosaicModifier(
                progress: 1,
                endX: endX,
                endY: endY
            )
        )
    }
}

struct MosaicModifier: ViewModifier {
    let progress: Double
    let endX: Int
    let endY: Int
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.mosaic(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(Float(endX)),
                            .float(Float(endY))
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == MosaicTransition {
    /// A transition that breaks the image into mosaic tiles that disappear randomly
    /// - Parameters:
    ///   - endX: Number of horizontal tiles (default: 10)
    ///   - endY: Number of vertical tiles (default: 10)
    /// - Returns: A custom transition with mosaic effect
    static func mosaic(
        endX: Int = 10,
        endY: Int = 10
    ) -> Self {
        MosaicTransition(endX: endX, endY: endY)
    }
}

public struct MosaicTransition: Transition {
    let endX: Int
    let endY: Int
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.mosaic(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(Float(endX)),
                            .float(Float(endY))
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
