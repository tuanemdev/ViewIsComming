import SwiftUI

public enum WindDirection: Sendable {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
    
    var rawValue: Float {
        switch self {
        case .leftToRight: return 0
        case .rightToLeft: return 1
        case .topToBottom: return 2
        case .bottomToTop: return 3
        }
    }
}

// MARK: - AnyTransition
public extension AnyTransition {
    static func wind(
        windSize: Double = 0.2,
        direction: WindDirection = .leftToRight
    ) -> AnyTransition {
        .modifier(
            active: WindModifier(
                progress: 0,
                windSize: windSize,
                direction: direction
            ),
            identity: WindModifier(
                progress: 1,
                windSize: windSize,
                direction: direction
            )
        )
    }
}

struct WindModifier: ViewModifier {
    let progress: Double
    let windSize: Double
    let direction: WindDirection
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.wind(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(windSize),
                            .float(direction.rawValue)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition
public extension Transition where Self == WindTransition {
    static func wind(
        windSize: Double = 0.2,
        direction: WindDirection = .leftToRight
    ) -> Self {
        WindTransition(
            windSize: windSize,
            direction: direction
        )
    }
}

public struct WindTransition: Transition {
    let windSize: Double
    let direction: WindDirection
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.wind(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(windSize),
                            .float(direction.rawValue)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
