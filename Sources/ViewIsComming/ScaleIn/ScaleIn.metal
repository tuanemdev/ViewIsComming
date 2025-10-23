#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Simple scale in effect - using native SwiftUI approach in wrapper
// This metal shader kept for consistency but could be replaced by .scaleEffect()

[[ stitchable ]] half4 scaleIn(float2 position,
                               SwiftUI::Layer layer,
                               float2 size,
                               float progress,
                               float scale) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Calculate scale from center
    float2 center = float2(0.5);
    float2 offset = uv - center;
    
    // Apply scale based on progress
    float currentScale = mix(scale, 1.0, progress);
    float2 scaledUV = center + offset / currentScale;
    
    // Check if within bounds
    float mask = (scaledUV.x >= 0.0 && scaledUV.x <= 1.0 && 
                  scaledUV.y >= 0.0 && scaledUV.y <= 1.0) ? 1.0 : 0.0;
    
    // Apply fade
    mask *= progress;
    
    return color * half(mask);
}
