#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// PolkaDotsCurtain transition
// Adapted from: https://gl-transitions.com/editor/PolkaDotsCurtain
// Author: bobylito
// License: MIT

[[ stitchable ]] half4 polkaDotsCurtain(float2 position,
                                         SwiftUI::Layer layer,
                                         float2 size,
                                         float progress,
                                         float dots,
                                         float2 center) {
    float2 uv = position / size;
    
    // Calculate distance from each dot center
    float2 fractUV = fract(uv * dots);
    float distFromDotCenter = distance(fractUV, float2(0.5, 0.5));
    
    // Distance from the specified center point
    float distFromCenter = distance(uv, center);
    
    // Check if we're inside a dot that should be revealed
    // Dots appear based on progress and distance from center
    bool nextImage = distFromDotCenter < (progress / distFromCenter);
    
    // If in next image, fade to transparent, otherwise show current
    float mask = nextImage ? 0.0 : (1.0 - progress);
    
    half4 color = layer.sample(position);
    return color * half(mask);
}
