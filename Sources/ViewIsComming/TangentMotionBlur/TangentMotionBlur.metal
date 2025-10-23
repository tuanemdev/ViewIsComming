#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// TangentMotionBlur - Tangent motion blur
// Ported from: https://gl-transitions.com/editor/TangentMotionBlur
// Author: Rich Harris
// License: MIT

[[ stitchable ]] half4 tangentMotionBlur(float2 position,
                                         SwiftUI::Layer layer,
                                         float2 size,
                                         float progress,
                                         float radius,
                                         float samples) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate angle and distance from center
    float angle = atan2(centered.y, centered.x);
    float dist = length(centered);
    
    // Sample count
    int sampleCount = int(samples);
    
    half4 sum = half4(0.0);
    
    // Blur along tangent
    for (int i = 0; i < sampleCount; i++) {
        float t = float(i) / float(sampleCount - 1) - 0.5;
        
        // Calculate offset along tangent direction
        float blurAngle = angle + t * radius * progress;
        float2 offset = float2(cos(blurAngle), sin(blurAngle)) * dist;
        
        float2 samplePos = (offset + 0.5) * size;
        sum += layer.sample(samplePos);
    }
    
    half4 color = sum / half(sampleCount);
    
    // Calculate mask
    float mask = smoothstep(0.0, 1.0, progress);
    
    return color * half(mask);
}
