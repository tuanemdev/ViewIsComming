#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// TVStatic transition
// Adapted from: https://gl-transitions.com/editor/TVStatic
// Author: Brandon Anzaldi
// License: MIT

// Pseudo-random noise function
float tvStaticNoise(float2 co, float progress) {
    float a = 12.9898;
    float b = 78.233;
    float c = 43758.5453;
    float dt = dot(co.xy * progress, float2(a, b));
    float sn = fmod(dt, 3.14);
    return fract(sin(sn) * c);
}

[[ stitchable ]] half4 tvStatic(float2 position,
                                 SwiftUI::Layer layer,
                                 float2 size,
                                 float progress,
                                 float offset) {
    float2 uv = position / size;
    
    // At the beginning and end, show the normal image
    // In the middle, show static
    if (progress < offset) {
        // Still showing original, but fading out
        half4 color = layer.sample(position);
        float mask = 1.0 - (progress / offset);
        return color * half(mask);
    } else if (progress > (1.0 - offset)) {
        // Should show next image, but we're transitioning out
        // So fade to transparent
        return half4(0.0);
    } else {
        // Show static noise
        float noise = tvStaticNoise(uv, progress);
        return half4(half3(noise), 1.0) * half(1.0 - progress);
    }
}
