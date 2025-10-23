import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func crazyParametricFun(
        a: Double = 4,
        b: Double = 1,
        amplitude: Double = 120,
        smoothness: Double = 0.1
    ) -> AnyTransition {
        .modifier(
            active: CrazyParametricFunModifier(
                progress: 0,
                a: a,
                b: b,
                amplitude: amplitude,
                smoothness: smoothness
            ),
            identity: CrazyParametricFunModifier(
                progress: 1,
                a: a,
                b: b,
                amplitude: amplitude,
                smoothness: smoothness
            )
        )
    }
}

struct CrazyParametricFunModifier: ViewModifier {
    let progress: Double
    let a: Double
    let b: Double
    let amplitude: Double
    let smoothness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.crazyParametricFun(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(a),
                            .float(b),
                            .float(amplitude),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == CrazyParametricFunTransition {
    static func crazyParametricFun(
        a: Double = 4,
        b: Double = 1,
        amplitude: Double = 120,
        smoothness: Double = 0.1
    ) -> Self {
        CrazyParametricFunTransition(
            a: a,
            b: b,
            amplitude: amplitude,
            smoothness: smoothness
        )
    }
}

public struct CrazyParametricFunTransition: Transition {
    let a: Double
    let b: Double
    let amplitude: Double
    let smoothness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.crazyParametricFun(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(a),
                            .float(b),
                            .float(amplitude),
                            .float(smoothness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
