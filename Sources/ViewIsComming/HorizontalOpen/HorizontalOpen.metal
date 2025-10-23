#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: 0gust1
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/directionalwarp.glsl
// Similar to horizontal open effect

[[ stitchable ]] half4 horizontalOpen(float2 position,
                                      SwiftUI::Layer layer,
                                      float2 size,
                                      float progress,
                                      float smoothness,
                                      float opening) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Calculate opening from center horizontally
    float centerDist = abs(uv.x - 0.5) * 2.0;
    
    // Apply smoothness and opening factor
    float openAmount = progress * (1.0 + opening);
    float edge = smoothstep(openAmount - smoothness, openAmount, centerDist);
    
    // Mask: 1.0 at progress = 1.0 (fully visible)
    float mask = 1.0 - edge;
    
    return color * half(mask);
}
