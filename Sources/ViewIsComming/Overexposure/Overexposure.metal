#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/Exponential_Swish.glsl

[[ stitchable ]] half4 overexposure(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float strength) {
    // Sample color
    half4 color = layer.sample(position);
    
    // Exponential overexposure effect
    float exposure = progress * strength;
    
    // The transition uses an exponential brightness increase
    // then fades out. At progress = 0.5, maximum overexposure
    float bright = 1.0 - abs(progress - 0.5) * 2.0;
    bright = pow(bright, 0.5) * exposure;
    
    // Calculate mask - view is visible at progress = 1.0
    float mask = progress;
    
    return color * half(mask);
}
