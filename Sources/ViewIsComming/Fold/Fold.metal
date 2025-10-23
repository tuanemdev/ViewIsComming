#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Fold - Folding effect
// Ported from: https://gl-transitions.com/editor/fold
// Author: bobylito
// License: MIT

[[ stitchable ]] half4 fold(float2 position,
                            SwiftUI::Layer layer,
                            float2 size,
                            float progress,
                            float folds,
                            float intensity) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate angle based on position and progress
    float angle = progress * 3.14159265359;
    
    // Calculate which fold we're in
    float foldNum = floor(centered.x * folds);
    float foldPos = fract(centered.x * folds);
    
    // Calculate fold intensity
    float foldIntensity = sin(angle + foldNum) * intensity;
    
    // Distort based on fold
    float2 distorted = centered;
    distorted.y += sin(foldPos * 3.14159265359) * foldIntensity;
    
    // Back to UV space
    distorted += 0.5;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask based on visibility
    float mask = 1.0;
    
    // Fade based on fold intensity
    float visibility = 1.0 - abs(foldIntensity) * progress;
    mask = smoothstep(0.0, 1.0, visibility);
    
    // Add shadow effect
    float shadow = 1.0 - abs(sin(angle + foldNum)) * 0.3 * progress;
    color = color * half(shadow);
    
    return color * half(mask);
}
