import SwiftUI

// MARK: - BowTie Orientation
public enum BowTieOrientation: Sendable {
    case horizontal
    case vertical
}

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// A transition that creates a bow tie (hourglass) reveal pattern
    /// - Parameter orientation: The orientation of the bow tie (horizontal or vertical)
    /// - Returns: A custom transition with bow tie effect
    static func bowTie(
        orientation: BowTieOrientation = .horizontal
    ) -> AnyTransition {
        .modifier(
            active: BowTieModifier(
                progress: 0,
                orientation: orientation
            ),
            identity: BowTieModifier(
                progress: 1,
                orientation: orientation
            )
        )
    }
}

struct BowTieModifier: ViewModifier {
    let progress: Double
    let orientation: BowTieOrientation
    
    func body(content: Content) -> some View {
        let isHorizontal = orientation == .horizontal
        
        return content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        isHorizontal ?
                        ViewIsCommingShaderLibrary.bowTieHorizontal(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ) :
                        ViewIsCommingShaderLibrary.bowTieVertical(
                            .float2(geometryProxy.size),
                            .float(progress)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == BowTieTransition {
    /// A transition that creates a bow tie (hourglass) reveal pattern
    /// - Parameter orientation: The orientation of the bow tie (horizontal or vertical)
    /// - Returns: A custom transition with bow tie effect
    static func bowTie(
        orientation: BowTieOrientation = .horizontal
    ) -> Self {
        BowTieTransition(orientation: orientation)
    }
}

public struct BowTieTransition: Transition {
    let orientation: BowTieOrientation
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        let isHorizontal = orientation == .horizontal
        
        return content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        isHorizontal ?
                        ViewIsCommingShaderLibrary.bowTieHorizontal(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ) :
                        ViewIsCommingShaderLibrary.bowTieVertical(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
