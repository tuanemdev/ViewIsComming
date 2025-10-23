#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Dreamy zoom effect with blur

[[ stitchable ]] half4 dreamyZoom(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float rotation,
                                  float scale) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 center = float2(0.5);
    float2 p = uv - center;
    
    // Calculate zoom and rotation based on progress
    float t = progress;
    float angle = t * rotation;
    float zoomFactor = 1.0 + (scale - 1.0) * t;
    
    // Apply rotation
    float s = sin(angle);
    float c = cos(angle);
    float2 rotated = float2(
        p.x * c - p.y * s,
        p.x * s + p.y * c
    );
    
    // Apply zoom
    float2 zoomed = rotated / zoomFactor;
    
    // Dreamy blur effect - sample multiple times
    half4 sum = half4(0.0);
    int samples = 10;
    
    for (int i = 0; i < samples; i++) {
        float offset = (float(i) / float(samples - 1) - 0.5) * 0.02 * (1.0 - t);
        float2 sampleUV = (zoomed + offset) + center;
        float2 samplePos = sampleUV * size;
        sum += layer.sample(samplePos);
    }
    
    half4 color = sum / half(samples);
    
    // Check bounds and apply mask
    float2 finalUV = zoomed + center;
    float mask = (finalUV.x >= 0.0 && finalUV.x <= 1.0 && 
                  finalUV.y >= 0.0 && finalUV.y <= 1.0) ? 1.0 : 0.0;
    
    mask *= progress;
    
    return color * half(mask);
}
