#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: mandubian
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/ButterflyWaveScrawler.glsl

#define PI 3.14159265358979323846264

float butterflyWave_compute(float2 p, float progress, float2 center, float amplitude, float waves) {
    float2 o = p * sin(progress * amplitude) - center;
    // horizontal vector
    float2 h = float2(1.0, 0.0);
    // butterfly polar function
    float theta = acos(dot(o, h)) * waves;
    return (exp(cos(theta)) - 2.0 * cos(4.0 * theta) + pow(sin((2.0 * theta - PI) / 24.0), 5.0)) / 10.0;
}

[[ stitchable ]] half4 butterflyWaveScrawler(float2 position,
                                             SwiftUI::Layer layer,
                                             float2 size,
                                             float progress,
                                             float amplitude,
                                             float waves,
                                             float colorSeparation) {
    
    // Calculate mask (fade in with progress)
    float mask = smoothstep(0.2, 1.0, progress);
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
