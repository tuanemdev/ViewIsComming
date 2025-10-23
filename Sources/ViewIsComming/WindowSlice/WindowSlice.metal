#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/windowslice.glsl

[[ stitchable ]] half4 windowSlice(float2 position,
                                   SwiftUI::Layer layer,
                                   float2 size,
                                   float progress,
                                   float count,
                                   float smoothness) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float pr = smoothstep(-smoothness, 0.0, uv.x - progress * (1.0 + smoothness));
    float s = step(pr, fract(count * uv.x));
    
    // Calculate mask
    float mask = s;
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
