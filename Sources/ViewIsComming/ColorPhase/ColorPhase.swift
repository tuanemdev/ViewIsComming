import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func colorPhase(
        fromStep: (r: Double, g: Double, b: Double, a: Double) = (0.0, 0.2, 0.4, 0.0),
        toStep: (r: Double, g: Double, b: Double, a: Double) = (0.6, 0.8, 1.0, 1.0)
    ) -> AnyTransition {
        .modifier(
            active: ColorPhaseModifier(
                progress: 0,
                fromStep: fromStep,
                toStep: toStep
            ),
            identity: ColorPhaseModifier(
                progress: 1,
                fromStep: fromStep,
                toStep: toStep
            )
        )
    }
}

struct ColorPhaseModifier: ViewModifier {
    let progress: Double
    let fromStep: (r: Double, g: Double, b: Double, a: Double)
    let toStep: (r: Double, g: Double, b: Double, a: Double)
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.colorPhase(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float4(Float(fromStep.r), Float(fromStep.g), Float(fromStep.b), Float(fromStep.a)),
                            .float4(Float(toStep.r), Float(toStep.g), Float(toStep.b), Float(toStep.a))
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == ColorPhaseTransition {
    static func colorPhase(
        fromStep: (r: Double, g: Double, b: Double, a: Double) = (0.0, 0.2, 0.4, 0.0),
        toStep: (r: Double, g: Double, b: Double, a: Double) = (0.6, 0.8, 1.0, 1.0)
    ) -> Self {
        ColorPhaseTransition(
            fromStep: fromStep,
            toStep: toStep
        )
    }
}

public struct ColorPhaseTransition: Transition {
    let fromStep: (r: Double, g: Double, b: Double, a: Double)
    let toStep: (r: Double, g: Double, b: Double, a: Double)
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.colorPhase(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float4(Float(fromStep.r), Float(fromStep.g), Float(fromStep.b), Float(fromStep.a)),
                            .float4(Float(toStep.r), Float(toStep.g), Float(toStep.b), Float(toStep.a))
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
