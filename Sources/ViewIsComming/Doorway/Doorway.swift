import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func doorway(
        reflection: Double = 0.4,
        perspective: Double = 0.4,
        depth: Double = 3.0
    ) -> AnyTransition {
        .modifier(
            active: DoorwayModifier(
                progress: 0,
                reflection: reflection,
                perspective: perspective,
                depth: depth
            ),
            identity: DoorwayModifier(
                progress: 1,
                reflection: reflection,
                perspective: perspective,
                depth: depth
            )
        )
    }
}

struct DoorwayModifier: ViewModifier {
    let progress: Double
    let reflection: Double
    let perspective: Double
    let depth: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.doorway(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(reflection),
                            .float(perspective),
                            .float(depth)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == DoorwayTransition {
    static func doorway(
        reflection: Double = 0.4,
        perspective: Double = 0.4,
        depth: Double = 3.0
    ) -> Self {
        DoorwayTransition(
            reflection: reflection,
            perspective: perspective,
            depth: depth
        )
    }
}

public struct DoorwayTransition: Transition {
    let reflection: Double
    let perspective: Double
    let depth: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.doorway(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(reflection),
                            .float(perspective),
                            .float(depth)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
