#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: Gunnar Roth based on work from natewave
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/GlitchMemories.glsl

[[ stitchable ]] half4 glitchMemories(float2 position,
                                      SwiftUI::Layer layer,
                                      float2 size,
                                      float progress) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float2 block = floor(uv * float2(16.0));
    float2 uv_noise = block / float2(64.0);
    uv_noise += floor(float2(progress) * float2(1200.0, 3500.0)) / float2(64.0);
    float2 dist = progress > 0.0 ? (fract(uv_noise) - 0.5) * 0.3 * (1.0 - progress) : float2(0.0);
    
    float2 red = uv + dist * 0.2;
    float2 green = uv + dist * 0.3;
    float2 blue = uv + dist * 0.5;
    
    half4 colorRed = layer.sample(red * size);
    half4 colorGreen = layer.sample(green * size);
    half4 colorBlue = layer.sample(blue * size);
    
    half4 result = half4(colorRed.r, colorGreen.g, colorBlue.b, 1.0);
    return result * half(progress);
}
