#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: haiyoucuv
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/rotateTransition.glsl

#define PI 3.1415926

float2 rotateTransition_rotate2D(float2 uv, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return float2(
        uv.x * c - uv.y * s,
        uv.x * s + uv.y * c
    );
}

[[ stitchable ]] half4 rotateTransition(float2 position,
                                        SwiftUI::Layer layer,
                                        float2 size,
                                        float progress) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float2 p = fract(rotateTransition_rotate2D(uv - 0.5, progress * PI * 2.0) + 0.5);
    
    // Calculate mask
    float mask = progress;
    
    // Sample and apply mask
    half4 color = layer.sample(p * size);
    return color * half(mask);
}
