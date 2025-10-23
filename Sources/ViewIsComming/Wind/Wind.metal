#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[stitchable]] half4 wind(float2 position,
                           SwiftUI::Layer layer,
                           float2 size,
                           float progress,
                           float windSize) {
    float2 uv = position / size;
    
    // Random function
    float r = fract(sin(uv.y * 12.9898 + 78.233) * 43758.5453);
    
    // Calculate mask with random offset
    // smoothstep creates smooth transition edge
    float m = smoothstep(0.0, -windSize, uv.x * (1.0 - windSize) + windSize * r - (progress * (1.0 + windSize)));
    
    // For SwiftUI: invert mask
    // progress 0 = hidden, progress 1 = visible
    m = 1.0 - m;
    
    half4 color = layer.sample(position);
    return color * half(m);
}
