#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Ported from https://github.com/gl-transitions/gl-transitions
// Author: pschroen
// License: MIT

[[ stitchable ]] half4 directionalWarp(float2 position,
                                       SwiftUI::Layer layer,
                                       float2 size,
                                       float progress,
                                       float2 direction,
                                       float smoothness) {
    // Normalize coordinates
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);
    
    // Normalize direction vector
    float2 v = normalize(direction);
    v /= abs(v.x) + abs(v.y);
    
    // Calculate distance from center along direction
    float d = v.x * center.x + v.y * center.y;
    
    // Calculate warp mask
    float m = 1.0 - smoothstep(-smoothness, 0.0, v.x * uv.x + v.y * uv.y - (d - 0.5 + progress * (1.0 + smoothness)));
    
    // Warp coordinates: contract one side, expand the other
    float2 warpedUV = (uv - 0.5) * mix(1.0 - m, m, step(0.5, progress)) + 0.5;
    
    // Sample with warped coordinates
    float2 warpedPos = warpedUV * size;
    
    // Bounds check
    bool inBounds = warpedUV.x >= 0.0 && warpedUV.x <= 1.0 && warpedUV.y >= 0.0 && warpedUV.y <= 1.0;
    
    half4 color = inBounds ? layer.sample(warpedPos) : half4(0.0);
    
    // Apply mask for visibility
    float mask = 1.0 - progress;
    
    return color * half(mask);
}
