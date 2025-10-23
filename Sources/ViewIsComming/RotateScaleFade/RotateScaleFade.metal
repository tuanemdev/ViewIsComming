#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: Mark Craig
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/rotate_scale_fade.glsl

[[ stitchable ]] half4 rotateScaleFade(float2 position,
                                       SwiftUI::Layer layer,
                                       float2 size,
                                       float progress,
                                       float2 center,
                                       float rotations,
                                       float scale) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float2 difference = uv - center;
    float2 dir = normalize(difference);
    float dist = length(difference);
    
    float angle = 2.0 * 3.14159265359 * rotations * progress;
    
    float c = cos(angle);
    float s = sin(angle);
    
    float currentScale = mix(scale, 1.0, progress);
    
    float2 rotatedDir = float2(dir.x * c - dir.y * s, dir.x * s + dir.y * c);
    float2 rotatedUv = center + rotatedDir * dist * currentScale;
    
    // Calculate mask
    float mask = progress;
    
    // Sample and apply mask
    half4 color = layer.sample(rotatedUv * size);
    return color * half(mask);
}
