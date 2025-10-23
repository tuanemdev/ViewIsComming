#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: mandubian
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/CrazyParametricFun.glsl

[[ stitchable ]] half4 crazyParametricFun(float2 position,
                                          SwiftUI::Layer layer,
                                          float2 size,
                                          float progress,
                                          float a,
                                          float b,
                                          float amplitude,
                                          float smoothness) {
    // Calculate mask (fade in from center)
    float mask = smoothstep(0.2, 1.0, progress);
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
