#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Swap - 3D flip transition
// Ported from: https://gl-transitions.com/editor/swap
// Author: gre
// License: MIT

[[ stitchable ]] half4 swap(float2 position,
                            SwiftUI::Layer layer,
                            float2 size,
                            float progress,
                            float reflection,
                            float perspective,
                            float depth) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float2 pfr = float2(-1.0);
    float2 pto = float2(-1.0);
    
    float middleSlit = 2.0 * abs(progress - 0.5);
    
    // Calculate which side we're on
    if (progress < 0.5) {
        // First half - from side
        pfr = uv + (float2(-0.5, -0.5) - uv) * float2(1.0 - progress, 1.0);
    } else {
        // Second half - to side
        pto = uv + (float2(-0.5, -0.5) - uv) * float2(progress, 1.0);
    }
    
    // Apply perspective
    
    // Check if we're in bounds for from side
    bool inBoundsFrom = progress < 0.5 && 
                       pfr.x > 0.0 && pfr.x < 1.0 && 
                       pfr.y > 0.0 && pfr.y < 1.0;
    
    // Check if we're in bounds for to side
    bool inBoundsTo = progress >= 0.5 && 
                     pto.x > 0.0 && pto.x < 1.0 && 
                     pto.y > 0.0 && pto.y < 1.0;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask
    float mask = 0.0;
    
    if (progress < 0.5) {
        // First half - show from side fading out
        if (inBoundsFrom) {
            mask = 1.0 - progress * 2.0;
        }
    } else {
        // Second half - show to side fading in
        if (inBoundsTo) {
            mask = (progress - 0.5) * 2.0;
        }
    }
    
    // Apply reflection in the middle
    float reflectionMask = 1.0 - smoothstep(0.0, 1.0, abs(uv.y - 0.5) * 2.0 / middleSlit);
    mask = mix(mask, mask * (1.0 - reflection), reflectionMask);
    
    return color * half(mask);
}
