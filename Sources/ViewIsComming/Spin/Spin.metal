#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Spin - Spinning transition effect
// Custom implementation

// Helper: Rotate 2D vector
float2 spin_rotate2D(float2 v, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return float2(v.x * c - v.y * s, v.x * s + v.y * c);
}

[[ stitchable ]] half4 spin(float2 position,
                            SwiftUI::Layer layer,
                            float2 size,
                            float progress,
                            float rotations,
                            float zoom) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate spin angle
    float angle = progress * rotations * 3.14159265359 * 2.0;
    
    // Apply spin rotation
    float2 spun = spin_rotate2D(centered, angle);
    
    // Apply zoom effect during spin
    float zoomFactor = 1.0 - progress * (1.0 - zoom);
    spun /= zoomFactor;
    
    // Back to UV space
    float2 finalUV = spun + 0.5;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask
    float mask = 1.0;
    
    // Check if we're out of bounds
    if (finalUV.x < 0.0 || finalUV.x > 1.0 || 
        finalUV.y < 0.0 || finalUV.y > 1.0) {
        mask = 0.0;
    } else {
        // Smooth fade based on progress
        mask = smoothstep(0.0, 1.0, progress);
    }
    
    // Add spin intensity effect
    float spinEffect = 1.0 - abs(sin(angle)) * 0.2;
    color = color * half(spinEffect);
    
    return color * half(mask);
}
