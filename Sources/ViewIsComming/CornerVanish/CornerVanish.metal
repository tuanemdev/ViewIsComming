#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// CornerVanish - Vanish from corners effect
// Custom implementation

[[ stitchable ]] half4 cornerVanish(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float cornerSize,
                                    float cornerFloat) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Cast float to int for corner selection
    int corner = int(cornerFloat);
    
    // Determine corner origin (0=TL, 1=TR, 2=BR, 3=BL)
    float2 cornerOrigin;
    if (corner == 0) {
        cornerOrigin = float2(0.0, 0.0); // Top-left
    } else if (corner == 1) {
        cornerOrigin = float2(1.0, 0.0); // Top-right
    } else if (corner == 2) {
        cornerOrigin = float2(1.0, 1.0); // Bottom-right
    } else {
        cornerOrigin = float2(0.0, 1.0); // Bottom-left
    }
    
    // Calculate distance from corner
    float dist = length(uv - cornerOrigin);
    
    // Maximum distance (diagonal)
    float maxDist = sqrt(2.0);
    
    // Calculate reveal threshold
    float threshold = progress * maxDist * (1.0 + cornerSize);
    
    // Create mask based on distance
    float mask = smoothstep(threshold - cornerSize, threshold, dist);
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    return color * half(mask);
}
