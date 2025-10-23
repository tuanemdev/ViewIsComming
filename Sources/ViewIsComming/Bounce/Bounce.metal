#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Bounce - Bouncing transition effect
// Ported from: https://gl-transitions.com/editor/Bounce
// Author: Adrian Purser
// License: MIT

[[ stitchable ]] half4 bounce(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress,
                              float bounces,
                              float shadowAlpha,
                              float shadowHeight) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Calculate bounce factor
    float bounceProgress = sin(progress * 3.14159265359 * bounces) * (1.0 - progress);
    
    // Apply vertical bounce
    float2 bouncedUV = uv;
    bouncedUV.y += bounceProgress * shadowHeight;
    
    // Sample the layer
    half4 color = layer.sample(bouncedUV * size);
    
    // Create shadow
    float shadowY = 1.0 - shadowHeight + bounceProgress * shadowHeight;
    float shadowDist = abs(uv.y - shadowY);
    float shadow = smoothstep(shadowHeight, 0.0, shadowDist) * shadowAlpha * (1.0 - progress);
    
    // Apply shadow (darken)
    color.rgb -= half3(shadow);
    
    // Apply mask
    float mask = progress;
    
    // Check bounds
    if (bouncedUV.y < 0.0 || bouncedUV.y > 1.0) {
        mask = 0.0;
    }
    
    return color * half(mask);
}
