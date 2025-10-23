import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    /// Simple cross-fade transition
    /// Directly fades between two views using opacity
    static var fade: AnyTransition {
        .opacity
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == FadeTransition {
    /// Simple cross-fade transition
    /// Directly fades between two views using opacity
    static var fade: Self {
        FadeTransition()
    }
}

public struct FadeTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .opacity(phase.isIdentity ? 1 : 0)
    }
}
