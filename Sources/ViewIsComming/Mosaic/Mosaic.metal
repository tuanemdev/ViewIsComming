#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Mosaic transition
// Adapted from: https://gl-transitions.com/editor/Mosaic
// Author: Xaychru
// License: MIT

// Random function
float mosaicRandom(float2 co) {
    return fract(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 mosaic(float2 position,
                               SwiftUI::Layer layer,
                               float2 size,
                               float progress,
                               int endx,
                               int endy) {
    float2 uv = position / size;
    
    // Calculate progress with different scaling
    float pr2 = smoothstep(0.0, 1.0, progress);
    
    // Calculate rotation based on progress
    float2 p = uv;
    
    // Apply rotation
    float r = mosaicRandom(float2(floor(p.x * float(endx)), floor(p.y * float(endy))));
    float cp = smoothstep(0.0, 1.0, r);
    
    if (pr2 < cp) {
        // Calculate tile
        float2 tile = float2(floor(p.x * float(endx)), floor(p.y * float(endy)));
        float2 tileUV = (tile + 0.5) / float2(float(endx), float(endy));
        
        // Convert to position
        float2 tilePos = tileUV * size;
        tilePos = clamp(tilePos, float2(0.0), size);
        
        half4 color = layer.sample(tilePos);
        
        // Fade out based on progress
        float mask = 1.0 - progress;
        return color * half(mask);
    }
    
    // Default: fade out
    half4 color = layer.sample(position);
    float mask = 1.0 - progress;
    return color * half(mask);
}
