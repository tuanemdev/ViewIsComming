#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// FilmBurn - Film burn effect
// Ported from: https://gl-transitions.com/editor/BurnFilm
// Custom implementation

// Helper: Noise function
float filmBurn_noise(float2 co) {
    return fract(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 filmBurn(float2 position,
                                SwiftUI::Layer layer,
                                float2 size,
                                float progress,
                                float burnSize,
                                float intensity) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Create burn pattern
    float noise = filmBurn_noise(uv * 10.0 + progress * 5.0);
    
    // Calculate burn threshold
    float burnThreshold = progress + (noise - 0.5) * burnSize;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate burn effect
    float burn = smoothstep(burnThreshold - 0.1, burnThreshold, uv.x + uv.y * 0.5);
    
    // Create bright burn edge
    float burnEdge = smoothstep(burnThreshold - 0.05, burnThreshold, uv.x + uv.y * 0.5) - burn;
    
    // Apply burn colors
    half4 burnColor = half4(1.0, 0.5, 0.0, 1.0) * half(intensity); // Orange burn
    color = mix(color, burnColor, half(burnEdge));
    
    // Calculate mask
    float mask = 1.0 - burn;
    
    return color * half(mask);
}
