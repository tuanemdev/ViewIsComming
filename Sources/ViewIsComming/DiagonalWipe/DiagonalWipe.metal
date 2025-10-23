#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Diagonal wipe transition

[[ stitchable ]] half4 diagonalWipe(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float2 direction,
                                    float smoothness) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Normalize direction
    float2 dir = normalize(direction);
    
    // Calculate diagonal position
    float diagonalPos = dot(uv, dir);
    
    // Apply wipe with smoothness
    float edge = smoothstep(progress - smoothness, progress + smoothness, diagonalPos);
    
    // Mask: 1.0 at progress = 1.0 (fully visible)
    float mask = 1.0 - edge;
    
    return color * half(mask);
}
