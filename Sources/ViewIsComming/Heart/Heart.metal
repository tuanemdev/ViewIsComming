#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Heart transition
// Adapted from: https://gl-transitions.com/editor/heart
// Author: gre
// License: MIT

[[ stitchable ]] half4 heart(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress) {
    float2 uv = position / size;
    
    // Center and adjust aspect ratio
    float aspectRatio = size.x / size.y;
    float2 p = (uv - float2(0.5, 0.4)) * float2(aspectRatio, 1.0);
    
    // Heart shape equation
    float a = atan2(p.y, p.x) / M_PI_F;
    float r = length(p);
    
    // Heart curve
    float h = abs(a);
    float d = (13.0 * h - 22.0 * h * h + 10.0 * h * h * h) / (6.0 - 5.0 * h);
    
    // Scale heart with progress
    float heartProgress = progress * 1.4;
    
    // Mask based on whether we're inside the heart
    float mask;
    if (r < d * heartProgress) {
        mask = 0.0; // Inside heart - hide
    } else {
        mask = 1.0; // Outside heart - show
    }
    
    // Smooth edge
    mask = smoothstep(d * heartProgress - 0.02, d * heartProgress + 0.02, r);
    
    half4 color = layer.sample(position);
    
    // Invert for proper transition (progress = 0 hidden, progress = 1 visible)
    return color * half(1.0 - mask);
}
