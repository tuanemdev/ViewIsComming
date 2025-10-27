#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 crossZoom(float2 position,
                SwiftUI::Layer layer,
                float2 size,
                float progress,
                float strength) {
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);
    // Zoom effect: zoom in the content as progress increases
    float zoomAmount = (1.0 - progress) * strength;
    float2 texCoord = mix(center, uv, 1.0 - zoomAmount);
    // Convert back to position
    float2 zoomedPos = texCoord * size;
    zoomedPos = clamp(zoomedPos, float2(0.0), size);
    // Sample the layer
    half4 color = layer.sample(zoomedPos);
    float mask = progress;
    return color * half(mask);
}
