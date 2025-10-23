#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/fadegrayscale.glsl

float3 fadeGrayscale_grayscale(float3 color) {
    return float3(0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b);
}

[[ stitchable ]] half4 fadeGrayscale(float2 position,
                                     SwiftUI::Layer layer,
                                     float2 size,
                                     float progress,
                                     float intensity) {
    half4 color = layer.sample(position);
    float3 rgb = float3(color.rgb);
    float3 gray = fadeGrayscale_grayscale(rgb);
    
    // Mix between grayscale and color based on progress and intensity
    float grayscaleMix = smoothstep(1.0 - intensity, 0.0, progress);
    float3 mixedColor = mix(gray, rgb, grayscaleMix);
    
    // Apply overall progress
    float mask = progress;
    
    return half4(half3(mixedColor), color.a) * half(mask);
}
