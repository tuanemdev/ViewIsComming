#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// CircleOpen transition
// Adapted from: https://gl-transitions.com/editor/circleopen
// Author: gre
// License: MIT

[[ stitchable ]] half4 circleOpen(float2 position,
                                   SwiftUI::Layer layer,
                                   float2 size,
                                   float progress,
                                   float smoothness,
                                   float opening) {
    float2 uv = position / size;
    
    // Correct aspect ratio
    float aspectRatio = size.x / size.y;
    float2 centered = uv - float2(0.5, 0.5);
    centered.x *= aspectRatio;
    
    float dist = length(centered);
    
    // Calculate mask based on whether we're opening or closing
    // opening = 1.0: circle expands (starts small, grows big)
    // opening = 0.0: circle contracts (starts big, shrinks small)
    float circleProgress = opening > 0.5 ? progress : (1.0 - progress);
    
    // Circle radius grows from 0 to sqrt(0.5) to cover full diagonal
    float maxRadius = sqrt(0.5 * aspectRatio * aspectRatio + 0.5);
    float radius = circleProgress * maxRadius;
    
    // Smooth edge
    float mask = 1.0 - smoothstep(radius - smoothness, radius + smoothness, dist);
    
    half4 color = layer.sample(position);
    return color * half(mask);
}
