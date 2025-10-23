#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Flower - Flower-shaped reveal transition
// Custom implementation

[[ stitchable ]] half4 flower(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress,
                              float petals,
                              float petalSize) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate polar coordinates
    float angle = atan2(centered.y, centered.x);
    float radius = length(centered);
    
    // Create flower shape using sine wave
    float petalShape = sin(angle * petals) * petalSize + (1.0 - petalSize);
    
    // Calculate reveal threshold
    float threshold = progress * 0.707 * petalShape; // 0.707 = sqrt(0.5)
    
    // Create mask
    float mask = smoothstep(threshold - 0.1, threshold + 0.1, radius);
    
    // Invert mask (reveal from center outward)
    mask = 1.0 - mask;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Apply progress-based fade
    mask *= progress;
    
    return color * half(mask);
}
