#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Interference - Interference pattern transition
// Custom implementation with wave interference

// Helper function for interference noise
float interference_noise(float2 p) {
    return fract(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 interference(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float frequency,
                                    float amplitude) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Calculate wave interference pattern
    float wave1 = sin(uv.x * frequency + progress * 10.0) * amplitude;
    float wave2 = sin(uv.y * frequency + progress * 10.0) * amplitude;
    float interference = (wave1 + wave2) * 0.5;
    
    // Add noise for texture
    float noise = interference_noise(uv * 100.0 + progress * 50.0);
    interference += noise * 0.1;
    
    // Calculate mask
    float mask = smoothstep(interference - 0.2, interference + 0.2, progress);
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    return color * half(mask);
}
