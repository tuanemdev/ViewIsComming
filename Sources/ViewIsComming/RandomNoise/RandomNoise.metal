#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: towrabbit
// License: MIT
// Simple random noise transition

// Helper function for random noise
float randomNoise_rand(float2 co) {
    return fract(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 randomNoise(float2 position,
                                   SwiftUI::Layer layer,
                                   float2 size,
                                   float progress,
                                   float density) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Generate random noise based on position and progress
    float2 noiseCoord = uv * density + float2(progress * 10.0);
    float noise = randomNoise_rand(noiseCoord);
    
    // Create mask: reveal gradually with random noise
    float threshold = progress * 1.2 - 0.1; // Extend range slightly
    float mask = step(noise, threshold);
    
    return color * half(mask);
}
