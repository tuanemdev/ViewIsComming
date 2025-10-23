#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// 3D cube rotation transition

[[ stitchable ]] half4 cube(float2 position,
                            SwiftUI::Layer layer,
                            float2 size,
                            float progress,
                            float perspective,
                            float unzoom) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Center coordinates
    float2 p = uv - 0.5;
    
    // Calculate cube rotation
    float angle = progress * M_PI_2_F; // 90 degrees
    
    // Apply perspective
    float z = perspective * (1.0 - cos(angle));
    float scale = 1.0 / (1.0 + z * unzoom);
    
    // Rotate in 3D space
    float2 rotated;
    rotated.x = p.x * cos(angle) * scale;
    rotated.y = p.y * scale;
    
    // Transform back to UV space
    float2 newUV = rotated + 0.5;
    
    // Check bounds
    float mask = (newUV.x >= 0.0 && newUV.x <= 1.0 && 
                  newUV.y >= 0.0 && newUV.y <= 1.0) ? 1.0 : 0.0;
    
    // Apply progress-based fade
    mask *= smoothstep(0.0, 0.3, progress);
    
    return color * half(mask);
}
