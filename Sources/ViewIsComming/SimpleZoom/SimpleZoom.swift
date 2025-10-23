import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func simpleZoom(
        zoomQuickness: Double = 0.8
    ) -> AnyTransition {
        .modifier(
            active: SimpleZoomModifier(
                progress: 0,
                zoomQuickness: zoomQuickness
            ),
            identity: SimpleZoomModifier(
                progress: 1,
                zoomQuickness: zoomQuickness
            )
        )
    }
}

struct SimpleZoomModifier: ViewModifier {
    let progress: Double
    let zoomQuickness: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.simpleZoom(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(zoomQuickness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == SimpleZoomTransition {
    static func simpleZoom(
        zoomQuickness: Double = 0.8
    ) -> Self {
        SimpleZoomTransition(zoomQuickness: zoomQuickness)
    }
}

public struct SimpleZoomTransition: Transition {
    let zoomQuickness: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.simpleZoom(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(zoomQuickness)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
