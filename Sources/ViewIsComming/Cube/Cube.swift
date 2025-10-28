import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func cube(
        perspective: Double = 0.7,
        unzoom: Double = 0.3,
        rotateRight: Bool = true
    ) -> AnyTransition {
        .modifier(
            active: CubeModifier(
                progress: 0,
                perspective: perspective,
                unzoom: unzoom,
                rotateRight: rotateRight
            ),
            identity: CubeModifier(
                progress: 1,
                perspective: perspective,
                unzoom: unzoom,
                rotateRight: rotateRight
            )
        )
    }
}

struct CubeModifier: ViewModifier {
    let progress: Double
    let perspective: Double
    let unzoom: Double
    let rotateRight: Bool
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.cube(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(perspective),
                            .float(unzoom),
                            .float(rotateRight ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == CubeTransition {
    static func cube(
        perspective: Double = 0.7,
        unzoom: Double = 0.3,
        rotateRight: Bool = true
    ) -> Self {
        CubeTransition(
            perspective: perspective,
            unzoom: unzoom,
            rotateRight: rotateRight
        )
    }
}

public struct CubeTransition: Transition {
    let perspective: Double
    let unzoom: Double
    let rotateRight: Bool
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.cube(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(perspective),
                            .float(unzoom),
                            .float(rotateRight ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
