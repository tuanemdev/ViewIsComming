import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func rotateScaleFade(
        center: CGPoint = CGPoint(x: 0.5, y: 0.5),
        rotations: Double = 1.0,
        scale: Double = 8.0
    ) -> AnyTransition {
        .modifier(
            active: RotateScaleFadeModifier(
                progress: 0,
                center: center,
                rotations: rotations,
                scale: scale
            ),
            identity: RotateScaleFadeModifier(
                progress: 1,
                center: center,
                rotations: rotations,
                scale: scale
            )
        )
    }
}

struct RotateScaleFadeModifier: ViewModifier {
    let progress: Double
    let center: CGPoint
    let rotations: Double
    let scale: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.rotateScaleFade(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(center.x), Float(center.y)),
                            .float(rotations),
                            .float(scale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == RotateScaleFadeTransition {
    static func rotateScaleFade(
        center: CGPoint = CGPoint(x: 0.5, y: 0.5),
        rotations: Double = 1.0,
        scale: Double = 8.0
    ) -> Self {
        RotateScaleFadeTransition(
            center: center,
            rotations: rotations,
            scale: scale
        )
    }
}

public struct RotateScaleFadeTransition: Transition {
    let center: CGPoint
    let rotations: Double
    let scale: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.rotateScaleFade(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(center.x), Float(center.y)),
                            .float(rotations),
                            .float(scale)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
