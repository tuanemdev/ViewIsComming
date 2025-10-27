import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func crossHatch(
        center: CGPoint = CGPoint(x: 0.5, y: 0.5),
        threshold: Double = 3.0,
        fadeEdge: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: CrossHatchModifier(
                progress: 0,
                center: center,
                threshold: threshold,
                fadeEdge: fadeEdge
            ),
            identity: CrossHatchModifier(
                progress: 1,
                center: center,
                threshold: threshold,
                fadeEdge: fadeEdge
            )
        )
    }
}

struct CrossHatchModifier: ViewModifier {
    let progress: Double
    let center: CGPoint
    let threshold: Double
    let fadeEdge: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.crossHatch(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(center.x), Float(center.y)),
                            .float(threshold),
                            .float(fadeEdge)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == CrossHatchTransition {
    static func crossHatch(
        center: CGPoint = CGPoint(x: 0.5, y: 0.5),
        threshold: Double = 3.0,
        fadeEdge: Double = 0.1
    ) -> Self {
        CrossHatchTransition(
            center: center,
            threshold: threshold,
            fadeEdge: fadeEdge
        )
    }
}

public struct CrossHatchTransition: Transition {
    let center: CGPoint
    let threshold: Double
    let fadeEdge: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.crossHatch(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(center.x), Float(center.y)),
                            .float(threshold),
                            .float(fadeEdge)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
