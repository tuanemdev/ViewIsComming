#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Dreamy transition
// Adapted from: https://gl-transitions.com/editor/Dreamy
// Author: mikolalysenko
// License: MIT

[[ stitchable ]] half4 dreamy(float2 position,
                               SwiftUI::Layer layer,
                               float2 size,
                               float progress) {
    float2 uv = position / size;
    
    // Dreamy effect - creates a blur/displacement that peaks at progress 0.5
    // The image appears to "dream" or become ethereal in the middle of transition
    float displacement = 2.0 * abs(progress - 0.5);
    
    // Sample multiple times with slight offsets to create blur
    half4 color = half4(0.0);
    float total = 0.0;
    
    // Number of samples for the blur
    const int samples = 9;
    
    for (int i = 0; i < samples; i++) {
        float angle = float(i) * 2.0 * M_PI_F / float(samples);
        float2 offset = float2(cos(angle), sin(angle)) * displacement * 0.03;
        
        float2 samplePos = (uv + offset) * size;
        samplePos = clamp(samplePos, float2(0.0), size);
        
        // Weight samples by their distance from center
        float weight = 1.0 - float(abs(i - samples/2)) / float(samples/2);
        
        color += layer.sample(samplePos) * half(weight);
        total += weight;
    }
    
    color /= half(total);
    
    // Calculate mask - fade out as progress increases
    float mask = 1.0 - progress;
    
    return color * half(mask);
}
