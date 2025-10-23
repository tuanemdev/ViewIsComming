#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// RotateScaleVanish - Rotate and scale vanishing effect
// Custom implementation combining rotation and scaling

// Helper: Rotate 2D vector
float2 rotateScaleVanish_rotate2D(float2 v, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return float2(v.x * c - v.y * s, v.x * s + v.y * c);
}

[[ stitchable ]] half4 rotateScaleVanish(float2 position,
                                         SwiftUI::Layer layer,
                                         float2 size,
                                         float progress,
                                         float rotations,
                                         float scaleAmount) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate rotation angle
    float angle = progress * rotations * 3.14159265359 * 2.0;
    
    // Apply rotation
    float2 rotated = rotateScaleVanish_rotate2D(centered, angle);
    
    // Apply scaling (shrink as progress increases)
    float scale = 1.0 + (scaleAmount - 1.0) * progress;
    rotated /= scale;
    
    // Back to UV space
    float2 finalUV = rotated + 0.5;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask
    float mask = 1.0;
    
    // Check if we're out of bounds
    if (finalUV.x < 0.0 || finalUV.x > 1.0 || 
        finalUV.y < 0.0 || finalUV.y > 1.0) {
        mask = 0.0;
    } else {
        // Fade based on progress
        mask = 1.0 - progress;
    }
    
    return color * half(mask);
}
