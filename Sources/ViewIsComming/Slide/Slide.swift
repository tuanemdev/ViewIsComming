import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that slides the content in a specified direction
    /// - Parameter direction: The direction vector for sliding (default: (-1, 0) for left)
    /// - Returns: A custom transition with slide effect
    static func slide(
        direction: CGVector = CGVector(dx: -1, dy: 0)
    ) -> AnyTransition {
        .modifier(
            active: SlideModifier(
                progress: 0,
                direction: direction
            ),
            identity: SlideModifier(
                progress: 1,
                direction: direction
            )
        )
    }
}

struct SlideModifier: ViewModifier {
    let progress: Double
    let direction: CGVector
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.slide(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float2(Float(direction.dx), Float(direction.dy))
                        ),
                        maxSampleOffset: CGSize(
                            width: abs(direction.dx) * 500,
                            height: abs(direction.dy) * 500
                        )
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == SlideTransition {
    /// A transition that slides the content in a specified direction
    /// - Parameter direction: The direction vector for sliding (default: (-1, 0) for left)
    /// - Returns: A custom transition with slide effect
    static func slide(
        direction: CGVector = CGVector(dx: -1, dy: 0)
    ) -> Self {
        SlideTransition(direction: direction)
    }
}

public struct SlideTransition: Transition {
    let direction: CGVector
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.slide(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float2(Float(direction.dx), Float(direction.dy))
                        ),
                        maxSampleOffset: CGSize(
                            width: abs(direction.dx) * 500,
                            height: abs(direction.dy) * 500
                        )
                    )
            }
    }
}
