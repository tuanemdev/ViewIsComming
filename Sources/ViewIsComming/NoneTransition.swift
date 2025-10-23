import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static var none: AnyTransition {
        .modifier(
            active: NoneModifier(opacity: 0),
            identity: NoneModifier(opacity: 1)
        )
    }
}

struct NoneModifier: ViewModifier {
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .background {
                EmptyView()
                    .opacity(opacity)
            }
    }
}

// MARK: - Transition
public extension Transition where Self == NoneTransition {
    static var none: Self {
        NoneTransition()
    }
}

public struct NoneTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .background {
                EmptyView()
                    .opacity(phase.isIdentity ? 1 : 0)
            }
    }
}
