#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Zoom with blur effect

[[ stitchable ]] half4 zoomBlur(float2 position,
                                SwiftUI::Layer layer,
                                float2 size,
                                float progress,
                                float strength,
                                float samples) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 center = float2(0.5);
    float2 toCenter = center - uv;
    
    // Calculate zoom and blur based on progress
    float blurAmount = strength * (1.0 - abs(progress - 0.5) * 2.0);
    
    // Sample multiple times for blur effect
    half4 sum = half4(0.0);
    int numSamples = int(samples);
    
    for (int i = 0; i < numSamples; i++) {
        float t = float(i) / float(numSamples - 1);
        
        // Radial zoom sampling
        float zoom = mix(1.0, 1.0 + blurAmount, t);
        float2 offset = toCenter * (1.0 - zoom);
        float2 sampleUV = uv + offset;
        float2 samplePos = sampleUV * size;
        
        sum += layer.sample(samplePos);
    }
    
    half4 color = sum / half(numSamples);
    
    // Apply mask based on progress
    float mask = progress;
    
    return color * half(mask);
}
