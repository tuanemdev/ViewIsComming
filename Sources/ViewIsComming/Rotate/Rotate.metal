#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: haiyoucuv
// License: MIT
// Simple rotation transition

// Helper function for rotation
float2 rotate_rotate2D(float2 pos, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return float2(
        pos.x * c - pos.y * s,
        pos.x * s + pos.y * c
    );
}

[[ stitchable ]] half4 rotate(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress,
                              float angle) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Center coordinates
    float2 p = uv - 0.5;
    
    // Calculate rotation angle based on progress
    float rotationAngle = progress * angle;
    
    // Apply rotation
    float2 rotated = rotate_rotate2D(p, rotationAngle);
    
    // Transform back to UV space
    float2 newUV = rotated + 0.5;
    
    // Check bounds
    float mask = (newUV.x >= 0.0 && newUV.x <= 1.0 && 
                  newUV.y >= 0.0 && newUV.y <= 1.0) ? 1.0 : 0.0;
    
    // Apply progress-based fade
    mask *= progress;
    
    return color * half(mask);
}
