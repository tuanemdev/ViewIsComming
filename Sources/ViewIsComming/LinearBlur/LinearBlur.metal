#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// LinearBlur transition
// Adapted from: https://gl-transitions.com/editor/LinearBlur
// Author: gre
// License: MIT

[[ stitchable ]] half4 linearBlur(float2 position,
                                   SwiftUI::Layer layer,
                                   float2 size,
                                   float progress,
                                   float intensity) {
    float2 uv = position / size;
    
    // Blur intensity peaks at progress = 0.5
    float blurAmount = intensity * sin(progress * M_PI_F);
    
    // Sample multiple times along a line for blur effect
    half4 color = half4(0.0);
    int samples = 13;
    
    for (int i = 0; i < samples; i++) {
        float offset = (float(i) / float(samples - 1) - 0.5) * blurAmount;
        float2 sampleUV = uv + float2(offset, 0.0);
        float2 samplePos = sampleUV * size;
        samplePos = clamp(samplePos, float2(0.0), size);
        
        color += layer.sample(samplePos);
    }
    
    color /= half(samples);
    
    // Fade out as progress increases
    float mask = 1.0 - progress;
    
    return color * half(mask);
}
