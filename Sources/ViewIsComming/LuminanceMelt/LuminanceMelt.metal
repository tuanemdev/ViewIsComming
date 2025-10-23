#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: 0gust1
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/luminance_melt.glsl

// Helper function for luminance calculation
float luminanceMelt_luminance(half3 color) {
    return dot(float3(color), float3(0.2126, 0.7152, 0.0722));
}

[[ stitchable ]] half4 luminanceMelt(float2 position,
                                     SwiftUI::Layer layer,
                                     float2 size,
                                     float progress,
                                     float direction,
                                     float threshold,
                                     float smoothness) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Calculate luminance
    float luma = luminanceMelt_luminance(color.rgb);
    
    // Determine direction (-1 for up/left, 1 for down/right)
    float dir = direction > 0.0 ? 1.0 : -1.0;
    
    // Calculate melt based on luminance threshold
    // Brighter pixels melt faster
    float meltSpeed = smoothstep(threshold - smoothness, threshold + smoothness, luma);
    
    // Calculate position-based reveal
    float reveal = abs(direction) > 0.5 
        ? uv.y  // Vertical melt
        : uv.x; // Horizontal melt
    
    // Adjust reveal direction
    if (dir < 0.0) {
        reveal = 1.0 - reveal;
    }
    
    // Combine progress, position, and luminance
    float meltThreshold = progress + meltSpeed * 0.3;
    float mask = smoothstep(meltThreshold - 0.1, meltThreshold, reveal);
    
    return color * half(1.0 - mask);
}
