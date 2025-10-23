#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Zoom transition
// Adapted from: https://gl-transitions.com/editor/zoom
// Author: rectalogic
// License: MIT

[[ stitchable ]] half4 zoom(float2 position,
                             SwiftUI::Layer layer,
                             float2 size,
                             float progress,
                             float strength) {
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);
    
    // Zoom effect - scale from center
    // At progress = 0, no zoom (scale = 1)
    // At progress = 0.5, maximum zoom out
    // At progress = 1, back to normal (scale = 1)
    float zoom = 1.0 - smoothstep(0.0, 1.0, abs(progress - 0.5) * 2.0) * strength;
    
    // Calculate zoomed UV coordinates
    float2 dir = uv - center;
    float2 zoomedUV = center + dir * zoom;
    
    // Convert to position
    float2 zoomedPos = zoomedUV * size;
    zoomedPos = clamp(zoomedPos, float2(0.0), size);
    
    // Sample at the zoomed position
    half4 color = layer.sample(zoomedPos);
    
    // Calculate mask - fade out as progress increases
    float mask = 1.0 - progress;
    
    return color * half(mask);
}
