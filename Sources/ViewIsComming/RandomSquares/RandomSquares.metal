#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/randomsquares.glsl

float randomSquares_rand(float2 co) {
    return fract(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 randomSquares(float2 position,
                                     SwiftUI::Layer layer,
                                     float2 size,
                                     float progress,
                                     float2 squareSize,
                                     float smoothness) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float2 squareCoord = floor(squareSize * uv);
    
    // Get random value for this square
    float r = randomSquares_rand(squareCoord);
    
    // Calculate mask (0.0 = hidden, 1.0 = visible)
    float m = smoothstep(0.0, -smoothness, r - (progress * (1.0 + smoothness)));
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(m);
}
