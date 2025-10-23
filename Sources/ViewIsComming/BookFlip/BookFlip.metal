#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: hong
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/BookFlip.glsl

float2 bookFlip_skewRight(float2 p, float progress) {
    float skewX = (p.x - progress) / (0.5 - progress) * 0.5;
    float skewY = (p.y - 0.5) / (0.5 + progress * (p.x - 0.5) / 0.5) * 0.5 + 0.5;
    return float2(skewX, skewY);
}

float2 bookFlip_skewLeft(float2 p, float progress) {
    float skewX = (p.x - 0.5) / (progress - 0.5) * 0.5 + 0.5;
    float skewY = (p.y - 0.5) / (0.5 + (1.0 - progress) * (0.5 - p.x) / 0.5) * 0.5 + 0.5;
    return float2(skewX, skewY);
}

[[ stitchable ]] half4 bookFlip(float2 position,
                                SwiftUI::Layer layer,
                                float2 size,
                                float progress) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float pr = smoothstep(0.0, 1.0, progress);
    float mask = 1.0;
    
    if (pr > 0.5) {
        if (uv.x > pr) {
            mask = 0.0;
        } else if (uv.x > 0.5) {
            float2 skewedUV = bookFlip_skewLeft(uv, pr);
            if (skewedUV.x < 0.5) {
                mask = 0.0;
            }
        }
    } else {
        if (uv.x < pr) {
            mask = 0.0;
        } else if (uv.x < 0.5) {
            float2 skewedUV = bookFlip_skewRight(uv, pr);
            if (skewedUV.x > 0.5) {
                mask = 0.0;
            }
        }
    }
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
