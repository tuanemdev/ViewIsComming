#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 circleCrop(float2 position,
                 SwiftUI::Layer layer,
                 float2 size,
                 float progress,
                 float smoothness) {
    float2 uv = position / size;
    // Center the UV coordinates
    float2 centered = uv - float2(0.5, 0.5);
    // Correct aspect ratio
    float aspectRatio = size.x / size.y;
    centered.x *= aspectRatio;
    float dist = length(centered);
    // Circle radius grows from 0 to cover full diagonal
    float maxRadius = sqrt(0.5 * aspectRatio * aspectRatio + 0.5);
    float radius = progress * maxRadius;
    // Use smoothstep for smooth edge transition
    float edge = smoothness * 0.1;
    float mask = smoothstep(radius - edge, radius + edge, dist);
    // Invert mask: inside circle = visible (1.0), outside = hidden (0.0)
    mask = 1.0 - mask;
    
    half4 color = layer.sample(position);
    return color * half(mask);
}
