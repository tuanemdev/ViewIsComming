#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// CrossZoom transition
// Adapted from: https://gl-transitions.com/editor/CrossZoom
// Author: rectalogic
// License: MIT

[[ stitchable ]] half4 crossZoom(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float strength) {
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);
    
    // Linear zoom
    float2 texCoord = mix(center, uv, 1.0 - progress * strength);
    
    // Convert back to position
    float2 zoomedPos = texCoord * size;
    zoomedPos = clamp(zoomedPos, float2(0.0), size);
    
    // Sample the layer
    half4 color = layer.sample(zoomedPos);
    
    // Fade out as progress increases
    float mask = 1.0 - progress;
    
    return color * half(mask);
}
