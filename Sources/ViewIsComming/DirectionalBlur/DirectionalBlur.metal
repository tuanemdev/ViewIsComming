#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// DirectionalBlur - Directional motion blur
// Ported from: https://gl-transitions.com/editor/directionalwarp
// Author: pschroen
// License: MIT

[[ stitchable ]] half4 directionalBlur(float2 position,
                                       SwiftUI::Layer layer,
                                       float2 size,
                                       float progress,
                                       float2 direction,
                                       float samples) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample count
    int sampleCount = int(samples);
    
    half4 sum = half4(0.0);
    
    // Blur along direction
    for (int i = 0; i < sampleCount; i++) {
        float t = float(i) / float(sampleCount - 1);
        
        // Offset based on direction and progress
        float2 offset = direction * (t - 0.5) * progress * 0.5;
        
        float2 samplePos = (uv + offset) * size;
        sum += layer.sample(samplePos);
    }
    
    half4 color = sum / half(sampleCount);
    
    // Calculate mask
    float mask = smoothstep(0.0, 1.0, progress);
    
    return color * half(mask);
}
