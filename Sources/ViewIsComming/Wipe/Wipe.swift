import SwiftUI

// MARK: - WipeUp Transition
public extension AnyTransition {
    static var wipeUp: AnyTransition {
        .modifier(
            active: WipeUpModifier(progress: 0),
            identity: WipeUpModifier(progress: 1)
        )
    }
}

struct WipeUpModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wipeUp(
                    .float2(geometryProxy.size),
                    .float(progress)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

public extension Transition where Self == WipeUpTransition {
    static var wipeUp: Self { WipeUpTransition() }
}

public struct WipeUpTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wipeUp(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

// MARK: - WipeDown Transition
public extension AnyTransition {
    static var wipeDown: AnyTransition {
        .modifier(
            active: WipeDownModifier(progress: 0),
            identity: WipeDownModifier(progress: 1)
        )
    }
}

struct WipeDownModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wipeDown(
                    .float2(geometryProxy.size),
                    .float(progress)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

public extension Transition where Self == WipeDownTransition {
    static var wipeDown: Self { WipeDownTransition() }
}

public struct WipeDownTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wipeDown(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

// MARK: - WipeLeft Transition
public extension AnyTransition {
    static var wipeLeft: AnyTransition {
        .modifier(
            active: WipeLeftModifier(progress: 0),
            identity: WipeLeftModifier(progress: 1)
        )
    }
}

struct WipeLeftModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wipeLeft(
                    .float2(geometryProxy.size),
                    .float(progress)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

public extension Transition where Self == WipeLeftTransition {
    static var wipeLeft: Self { WipeLeftTransition() }
}

public struct WipeLeftTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wipeLeft(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

// MARK: - WipeRight Transition
public extension AnyTransition {
    static var wipeRight: AnyTransition {
        .modifier(
            active: WipeRightModifier(progress: 0),
            identity: WipeRightModifier(progress: 1)
        )
    }
}

struct WipeRightModifier: ViewModifier {
    let progress: Double
    
    func body(content: Content) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wipeRight(
                    .float2(geometryProxy.size),
                    .float(progress)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}

public extension Transition where Self == WipeRightTransition {
    static var wipeRight: Self { WipeRightTransition() }
}

public struct WipeRightTransition: Transition {
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.visualEffect { content, geometryProxy in
            content.layerEffect(
                ViewIsCommingShaderLibrary.wipeRight(
                    .float2(geometryProxy.size),
                    .float(phase.isIdentity ? 1 : 0)
                ),
                maxSampleOffset: .zero
            )
        }
    }
}
