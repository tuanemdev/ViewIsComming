import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates an inverted page curl effect.
    ///
    /// - Parameters:
    ///   - angle: Curl angle in degrees (0 to 360). Default is 135.
    ///   - radius: Curl radius (0.0 to 1.0). Default is 0.1.
    /// - Returns: A transition that creates an inverted page curl effect.
    static func invertedPageCurl(
        angle: Double = 135.0,
        radius: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: InvertedPageCurlModifier(
                progress: 0,
                angle: angle,
                radius: radius
            ),
            identity: InvertedPageCurlModifier(
                progress: 1,
                angle: angle,
                radius: radius
            )
        )
    }
}

struct InvertedPageCurlModifier: ViewModifier {
    let progress: Double
    let angle: Double
    let radius: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.invertedPageCurl(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(angle),
                            .float(radius)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == InvertedPageCurlTransition {
    /// A transition that creates an inverted page curl effect.
    ///
    /// - Parameters:
    ///   - angle: Curl angle in degrees (0 to 360). Default is 135.
    ///   - radius: Curl radius (0.0 to 1.0). Default is 0.1.
    /// - Returns: A transition that creates an inverted page curl effect.
    static func invertedPageCurl(
        angle: Double = 135.0,
        radius: Double = 0.1
    ) -> Self {
        InvertedPageCurlTransition(
            angle: angle,
            radius: radius
        )
    }
}

public struct InvertedPageCurlTransition: Transition {
    let angle: Double
    let radius: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.invertedPageCurl(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(angle),
                            .float(radius)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
