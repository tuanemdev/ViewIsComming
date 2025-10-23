#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// 3D doorway effect

[[ stitchable ]] half4 doorway(float2 position,
                               SwiftUI::Layer layer,
                               float2 size,
                               float progress,
                               float reflection,
                               float perspective,
                               float depth) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Center coordinates
    float2 p = uv - 0.5;
    
    // Calculate 3D perspective doorway effect
    float angle = progress * M_PI_2_F;
    
    // Apply perspective distortion
    float z = depth * sin(angle);
    float scale = 1.0 / (1.0 + abs(p.x) * perspective * z);
    
    // Apply rotation effect
    float2 rotated;
    rotated.x = p.x * cos(angle) * scale;
    rotated.y = p.y * scale;
    
    // Add reflection effect
    float reflectionAmount = reflection * (1.0 - progress);
    if (rotated.x < 0.0) {
        rotated.x = abs(rotated.x) * reflectionAmount;
    }
    
    // Transform back to UV space
    float2 newUV = rotated + 0.5;
    
    // Check bounds
    float mask = (newUV.x >= 0.0 && newUV.x <= 1.0 && 
                  newUV.y >= 0.0 && newUV.y <= 1.0) ? 1.0 : 0.0;
    
    // Apply progress-based fade
    mask *= smoothstep(0.0, 0.3, progress);
    
    return color * half(mask);
}
