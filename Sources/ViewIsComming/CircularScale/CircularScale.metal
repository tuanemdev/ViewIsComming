#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// CircularScale - Circular scaling transition
// Custom implementation

[[ stitchable ]] half4 circularScale(float2 position,
                                     SwiftUI::Layer layer,
                                     float2 size,
                                     float progress,
                                     float scale,
                                     float smoothness) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate distance from center
    float dist = length(centered);
    
    // Calculate circular scale based on distance
    float scaleFactor = 1.0 - progress * (1.0 - scale);
    
    // Apply circular scaling
    float2 scaled = centered / scaleFactor;
    
    // Back to UV space
    float2 finalUV = scaled + 0.5;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask based on circular bounds
    float mask = 1.0;
    
    // Check if scaled position is out of bounds
    if (finalUV.x < 0.0 || finalUV.x > 1.0 || 
        finalUV.y < 0.0 || finalUV.y > 1.0) {
        mask = 0.0;
    } else {
        // Smooth circular fade
        float fadeDist = dist / (0.7 * progress + 0.01);
        mask = smoothstep(1.0, 1.0 - smoothness, fadeDist) * smoothstep(0.0, smoothness, progress);
    }
    
    return color * half(mask);
}
