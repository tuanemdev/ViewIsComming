#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/DirectionalScaled.glsl

// Helper function for directional easing
float directionalEasing_easeInOut(float t) {
    return t < 0.5 
        ? 2.0 * t * t 
        : -1.0 + (4.0 - 2.0 * t) * t;
}

[[ stitchable ]] half4 directionalEasing(float2 position,
                                         SwiftUI::Layer layer,
                                         float2 size,
                                         float progress,
                                         float2 direction,
                                         float scale) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Normalize direction
    float2 dir = normalize(direction);
    
    // Apply easing to progress
    float easedProgress = directionalEasing_easeInOut(progress);
    
    // Calculate directional offset
    float dist = dot(uv - float2(0.5), dir);
    
    // Apply scale and direction
    float threshold = easedProgress * (1.0 + scale) - scale * 0.5;
    float mask = smoothstep(threshold - 0.1, threshold, dist + 0.5);
    
    return color * half(1.0 - mask);
}
