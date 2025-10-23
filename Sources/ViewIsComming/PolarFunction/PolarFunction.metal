#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: Fernando Kuteken
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/polar_function.glsl

#define PI 3.14159265359

[[ stitchable ]] half4 polarFunction(float2 position,
                                     SwiftUI::Layer layer,
                                     float2 size,
                                     float progress,
                                     float segments) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float angle = atan2(uv.y - 0.5, uv.x - 0.5) - 0.5 * PI;
    
    float radius = (cos(segments * angle) + 4.0) / 4.0;
    float difference = length(uv - float2(0.5, 0.5));
    
    float mask = 1.0 - step(difference, radius * progress);
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
