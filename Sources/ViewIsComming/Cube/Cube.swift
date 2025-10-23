import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func cube(
        perspective: Double = 0.7,
        unzoom: Double = 0.3
    ) -> AnyTransition {
        .modifier(
            active: CubeModifier(
                progress: 0,
                perspective: perspective,
                unzoom: unzoom
            ),
            identity: CubeModifier(
                progress: 1,
                perspective: perspective,
                unzoom: unzoom
            )
        )
    }
}

struct CubeModifier: ViewModifier {
    let progress: Double
    let perspective: Double
    let unzoom: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.cube(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(perspective),
                            .float(unzoom)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == CubeTransition {
    static func cube(
        perspective: Double = 0.7,
        unzoom: Double = 0.3
    ) -> Self {
        CubeTransition(
            perspective: perspective,
            unzoom: unzoom
        )
    }
}

public struct CubeTransition: Transition {
    let perspective: Double
    let unzoom: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.cube(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(perspective),
                            .float(unzoom)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
