import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func doorway(
        reflection: Double = 0.4,
        perspective: Double = 0.4,
        depth: Double = 3.0
    ) -> AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: DoorwayModifier(
                    progress: 0,
                    depth: depth,
                    perspective: perspective,
                    reflection: reflection,
                    isInsertion: true
                ),
                identity: DoorwayModifier(
                    progress: 1,
                    depth: depth,
                    perspective: perspective,
                    reflection: reflection,
                    isInsertion: true
                )
            ),
            removal: .modifier(
                active: DoorwayModifier(
                    progress: 1,
                    depth: depth,
                    perspective: perspective,
                    reflection: reflection,
                    isInsertion: false
                ),
                identity: DoorwayModifier(
                    progress: 0,
                    depth: depth,
                    perspective: perspective,
                    reflection: reflection,
                    isInsertion: false
                )
            )
        )
    }
}

struct DoorwayModifier: ViewModifier {
    let progress: Double
    let depth: Double
    let perspective: Double
    let reflection: Double
    let isInsertion: Bool
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.doorway(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(depth),
                            .float(perspective),
                            .float(reflection),
                            .float(isInsertion ? 1.0 : 0.0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
