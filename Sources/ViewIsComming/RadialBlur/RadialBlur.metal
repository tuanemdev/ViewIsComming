#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Radial blur from center

[[ stitchable ]] half4 radialBlur(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float samples) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center point
    float2 center = float2(0.5);
    float2 toCenter = center - uv;
    
    // Calculate blur amount based on progress
    float blurAmount = progress * 0.1;
    
    // Sample multiple times along radius for blur effect
    half4 sum = half4(0.0);
    int numSamples = int(samples);
    
    for (int i = 0; i < numSamples; i++) {
        float t = float(i) / float(numSamples - 1);
        float2 offset = toCenter * blurAmount * t;
        float2 samplePos = position + offset * size;
        sum += layer.sample(samplePos);
    }
    
    half4 color = sum / half(numSamples);
    
    // Apply mask based on progress
    float mask = progress;
    
    return color * half(mask);
}
