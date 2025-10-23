#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Swirl transition
// Adapted from: https://gl-transitions.com/editor/Swirl
// Author: Sergey Kosarevsky
// License: MIT

[[ stitchable ]] half4 swirl(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress) {
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);
    
    // Calculate angle and distance from center
    float2 dir = uv - center;
    float dist = length(dir);
    
    // Swirl effect - rotate based on distance and progress
    // The rotation is stronger near the center and decreases with distance
    float angle = progress * 10.0 * (1.0 - dist);
    
    // Create rotation matrix
    float cosA = cos(angle);
    float sinA = sin(angle);
    
    // Apply rotation
    float2 rotated;
    rotated.x = dir.x * cosA - dir.y * sinA;
    rotated.y = dir.x * sinA + dir.y * cosA;
    
    // New UV coordinates after rotation
    float2 swirlUV = center + rotated;
    
    // Calculate position from UV
    float2 swirlPos = swirlUV * size;
    
    // Ensure position is within bounds
    swirlPos = clamp(swirlPos, float2(0.0), size);
    
    // Sample the layer at the swirled position
    half4 color = layer.sample(swirlPos);
    
    // Calculate alpha mask - fade out as progress increases
    float mask = 1.0 - smoothstep(0.0, 1.0, progress);
    
    return color * half(mask);
}
