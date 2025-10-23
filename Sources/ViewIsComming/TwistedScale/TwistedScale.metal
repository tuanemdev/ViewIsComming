#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// TwistedScale - Twisted scaling effect
// Custom implementation inspired by rotation and scaling transitions

// Helper: Rotate 2D vector
float2 twistedScale_rotate2D(float2 v, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return float2(v.x * c - v.y * s, v.x * s + v.y * c);
}

[[ stitchable ]] half4 twistedScale(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float rotations,
                                    float scale) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate distance from center
    float dist = length(centered);
    
    // Calculate twist angle based on distance and progress
    float twistAmount = dist * rotations * 3.14159265359 * 2.0 * progress;
    
    // Apply twist rotation
    float2 twisted = twistedScale_rotate2D(centered, twistAmount);
    
    // Apply scaling based on progress
    float currentScale = 1.0 - progress * (1.0 - scale);
    twisted /= currentScale;
    
    // Back to UV space
    float2 finalUV = twisted + 0.5;
    
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
        mask = smoothstep(0.0, 1.0, progress);
    }
    
    return color * half(mask);
}
