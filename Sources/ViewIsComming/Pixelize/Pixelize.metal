#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Pixelize transition
// Adapted from: https://gl-transitions.com/editor/pixelize
// Author: gre
// License: MIT

[[ stitchable ]] half4 pixelize(float2 position,
                                 SwiftUI::Layer layer,
                                 float2 size,
                                 float progress,
                                 float squaresMin,
                                 float steps) {
    float2 uv = position / size;
    
    // Calculate the pixelization level
    // As progress increases, pixels get larger (more pixelated) then smaller
    float d = min(progress, 1.0 - progress);
    float dist = steps > 0.0 ? ceil(d * steps) / steps : d;
    
    // Number of squares changes with progress
    float squares = squaresMin + dist * (50.0 - squaresMin);
    
    // Calculate pixelated UV coordinates
    float2 pixelSize = float2(1.0 / squares);
    float2 pixelatedUV = floor(uv / pixelSize) * pixelSize + pixelSize * 0.5;
    
    // Convert back to position
    float2 pixelatedPos = pixelatedUV * size;
    pixelatedPos = clamp(pixelatedPos, float2(0.0), size);
    
    // Sample at the pixelated position
    half4 color = layer.sample(pixelatedPos);
    
    // Calculate mask - fade out as progress increases
    float mask = 1.0 - progress;
    
    return color * half(mask);
}
