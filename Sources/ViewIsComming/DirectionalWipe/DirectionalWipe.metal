#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// DirectionalWipe transition
// Adapted from: https://gl-transitions.com/editor/directionalwipe
// Author: pschroen
// License: MIT

[[ stitchable ]] half4 directionalWipe(float2 position,
                                        SwiftUI::Layer layer,
                                        float2 size,
                                        float progress,
                                        float2 direction,
                                        float smoothness) {
    float2 uv = position / size;
    
    // Normalize direction
    float2 dir = normalize(direction);
    
    // Calculate the wipe progress along the direction
    float2 center = float2(0.5, 0.5);
    float dist = dot(uv - center, dir);
    
    // Create smooth wipe edge
    float edge = progress * 2.0 - 1.0; // Map progress from [0,1] to [-1,1]
    float mask = smoothstep(edge - smoothness, edge + smoothness, dist);
    
    half4 color = layer.sample(position);
    
    // Invert mask so that progress = 0 is hidden, progress = 1 is visible
    return color * half(1.0 - mask);
}
