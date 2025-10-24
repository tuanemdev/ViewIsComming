import SwiftUI

public enum BookFlipDirection: Sendable {
    case left
    case right
    
    public var opposite: BookFlipDirection {
        switch self {
        case .left:
            return .right
        case .right:
            return .left
        }
    }
}

// MARK: - AnyTransition
public extension AnyTransition {
    static func bookFlip(direction: BookFlipDirection = .right) -> AnyTransition {
        .modifier(
            active: BookFlipModifier(progress: 0, direction: direction),
            identity: BookFlipModifier(progress: 1, direction: direction)
        )
    }
}

struct BookFlipModifier: ViewModifier {
    let progress: Double
    let direction: BookFlipDirection
    
    func body(content: Content) -> some View {
        let flipRight = direction == .right ? 1.0 : 0.0
        
        return content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.bookFlip(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(flipRight)
                        ),
                        maxSampleOffset: CGSize(
                            width: geometryProxy.size.width / 2,
                            height: geometryProxy.size.height / 2
                        )
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == BookFlipTransition {
    static func bookFlip(direction: BookFlipDirection = .right) -> Self {
        BookFlipTransition(direction: direction)
    }
}

public struct BookFlipTransition: Transition {
    let direction: BookFlipDirection
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        let flipRight = direction == .right ? 1.0 : 0.0
        
        return content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.bookFlip(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(flipRight)
                        ),
                        maxSampleOffset: CGSize(
                            width: geometryProxy.size.width / 2,
                            height: geometryProxy.size.height / 2
                        )
                    )
            }
    }
}
