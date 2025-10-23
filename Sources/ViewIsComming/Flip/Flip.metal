#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Flip - 3D flip transition
// Ported from: https://gl-transitions.com/editor/Flyeye
// Custom implementation

[[ stitchable ]] half4 flip(float2 position,
                            SwiftUI::Layer layer,
                            float2 size,
                            float progress,
                            float axis,
                            float perspective) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate flip amount
    float flipAngle = progress * 3.14159265359;
    
    // Determine flip axis (0 = horizontal, 1 = vertical)
    float flipFactor = axis < 0.5 ? 
        cos(flipAngle + centered.y * perspective) :
        cos(flipAngle + centered.x * perspective);
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask based on flip
    float mask = smoothstep(-0.5, 0.5, flipFactor);
    
    // Add darkening during flip
    float darkness = 1.0 - abs(sin(flipAngle)) * 0.5;
    color = color * half(darkness);
    
    return color * half(mask);
}
