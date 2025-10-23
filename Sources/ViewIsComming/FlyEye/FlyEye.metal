#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/flyeye.glsl

[[ stitchable ]] half4 flyEye(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress,
                              float eyeSize,
                              float zoom,
                              float colorSeparation) {
    // Calculate mask based on progress
    float mask = progress;
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
