#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Slide transition
// Adapted from: https://gl-transitions.com/editor/slide
// Author: Fernando Kuteken
// License: MIT

[[ stitchable ]] half4 slide(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress,
                              float2 direction) {
    float2 uv = position / size;
    
    // Slide the image in the opposite direction of the specified vector
    float2 offset = direction * progress;
    float2 slidUV = uv + offset;
    
    // Check if we're still within bounds
    if (slidUV.x < 0.0 || slidUV.x > 1.0 || slidUV.y < 0.0 || slidUV.y > 1.0) {
        return half4(0.0);
    }
    
    float2 slidePos = slidUV * size;
    half4 color = layer.sample(slidePos);
    
    // Fade based on progress
    float mask = 1.0 - progress;
    return color * half(mask);
}
