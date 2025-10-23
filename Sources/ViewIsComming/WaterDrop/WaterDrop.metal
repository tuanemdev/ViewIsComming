#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// WaterDrop transition
// Adapted from: https://gl-transitions.com/editor/WaterDrop
// Author: Paweł Płóciennik
// License: MIT

[[ stitchable ]] half4 waterDrop(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float amplitude,
                                  float speed) {
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);
    
    // Calculate distance from center
    float2 dir = uv - center;
    float dist = length(dir);
    
    // Water drop effect - distortion that grows and moves outward
    // Only apply distortion in a ring that expands with progress
    if (dist > 0.0 && progress > 0.0) {
        // Ring position based on progress
        float ringDist = abs(dist - progress);
        
        // Apply distortion in the ring area
        float dropFactor = 1.0 - smoothstep(0.0, amplitude, ringDist);
        
        // Oscillating distortion
        float drop = dropFactor * sin(dist * speed - progress * speed);
        
        // Displace UV coordinates
        float2 offset = normalize(dir) * drop * amplitude;
        position += offset * size;
        
        // Ensure position is within bounds
        position = clamp(position, float2(0.0), size);
    }
    
    // Sample the layer at the (possibly distorted) position
    half4 color = layer.sample(position);
    
    // Calculate alpha mask - fade out as progress increases
    // The distorted area gradually becomes transparent
    float mask = 1.0 - smoothstep(0.0, 1.0, progress);
    
    return color * half(mask);
}
