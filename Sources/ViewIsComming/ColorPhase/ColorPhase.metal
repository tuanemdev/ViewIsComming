#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: gre
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/colorphase.glsl

[[ stitchable ]] half4 colorPhase(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float4 fromStep,
                                  float4 toStep) {
    // Sample color
    half4 color = layer.sample(position);
    
    // Calculate smooth transition for each channel
    float4 smoothProg = smoothstep(fromStep, toStep, float4(progress));
    
    // Apply the smooth transition as mask
    float mask = (smoothProg.r + smoothProg.g + smoothProg.b) / 3.0;
    
    return color * half(mask);
}
