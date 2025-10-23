#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// BowTie transition
// Adapted from: https://gl-transitions.com/editor/BowTieHorizontal
// Author: huynx
// License: MIT

[[ stitchable ]] half4 bowTieHorizontal(float2 position,
                                         SwiftUI::Layer layer,
                                         float2 size,
                                         float progress) {
    float2 uv = position / size;
    
    // Bow tie shape - creates a horizontal hourglass/bow tie pattern
    float px = progress - 0.5;
    float h = 1.0 - abs(px * 2.0);
    
    // Check if we're in the revealed area
    float bottom = uv.y;
    float top = 1.0 - uv.y;
    
    float mask;
    if (progress < 0.5) {
        // First half: reveal from edges to center
        mask = step(h, min(bottom, top) * 2.0);
    } else {
        // Second half: reveal from center to edges
        mask = 1.0 - step(h, min(bottom, top) * 2.0);
    }
    
    half4 color = layer.sample(position);
    return color * half(mask);
}

[[ stitchable ]] half4 bowTieVertical(float2 position,
                                       SwiftUI::Layer layer,
                                       float2 size,
                                       float progress) {
    float2 uv = position / size;
    
    // Vertical bow tie shape
    float px = progress - 0.5;
    float h = 1.0 - abs(px * 2.0);
    
    // Check if we're in the revealed area
    float left = uv.x;
    float right = 1.0 - uv.x;
    
    float mask;
    if (progress < 0.5) {
        // First half: reveal from edges to center
        mask = step(h, min(left, right) * 2.0);
    } else {
        // Second half: reveal from center to edges
        mask = 1.0 - step(h, min(left, right) * 2.0);
    }
    
    half4 color = layer.sample(position);
    return color * half(mask);
}
