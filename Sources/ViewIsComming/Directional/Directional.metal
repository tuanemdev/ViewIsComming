#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Directional transition
// Adapted from: https://gl-transitions.com/editor/Directional
// Author: Gaëtan Renaudeau
// License: MIT

[[ stitchable ]] half4 directional(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float2 direction) {
    float2 uv = position / size;
    
    // Add progress in the direction
    float2 p = uv + progress * sign(direction);
    float2 f = fract(p);
    
    // Check if we're still within bounds
    float inBounds = step(0.0, p.y) * step(p.y, 1.0) * step(0.0, p.x) * step(p.x, 1.0);
    
    // Sample at the fractional position
    float2 samplePos = f * size;
    samplePos = clamp(samplePos, float2(0.0), size);
    half4 color = layer.sample(samplePos);
    
    // If out of bounds, fade to transparent
    // If in bounds, use the sampled color
    float mask = (1.0 - progress) * inBounds;
    
    return color * half(mask);
}
