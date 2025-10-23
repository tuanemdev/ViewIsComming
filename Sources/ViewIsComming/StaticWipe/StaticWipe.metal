#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: Ben Lucas
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/static-wipe.glsl

// Helper function for static wipe
float staticWipe_rand(float2 co) {
    return fract(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 staticWipe(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float upToDown,
                                  float maximumStatic,
                                  float staticFade) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Sample color
    half4 color = layer.sample(position);
    
    // Determine direction
    float y = upToDown > 0.5 ? uv.y : 1.0 - uv.y;
    
    // Calculate static noise
    float staticAmount = staticWipe_rand(float2(uv.x, y)) * maximumStatic;
    
    // Calculate reveal threshold with static
    float threshold = progress + staticAmount;
    
    // Apply static fade
    float mask = smoothstep(threshold - staticFade, threshold, y);
    
    return color * half(1.0 - mask);
}
