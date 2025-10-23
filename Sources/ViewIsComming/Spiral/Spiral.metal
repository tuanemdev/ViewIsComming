#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Spiral pattern transition

[[ stitchable ]] half4 spiral(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress,
                              float rotations) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Center coordinates
    float2 p = uv - 0.5;
    
    // Calculate polar coordinates
    float radius = length(p);
    float angle = atan2(p.y, p.x);
    
    // Create spiral effect
    float spiralAngle = angle + radius * rotations * M_PI_F * 2.0;
    
    // Calculate mask based on spiral and progress
    float spiralProgress = fract((spiralAngle / (M_PI_F * 2.0)) + progress);
    
    float mask = smoothstep(0.5 - 0.1, 0.5 + 0.1, spiralProgress);
    
    // Combine with radial progress
    mask *= smoothstep(progress - 0.1, progress, radius * 1.414);
    
    return color * half(mask);
}
