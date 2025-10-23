#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Checkerboard - Checkerboard pattern transition
// Ported from: https://gl-transitions.com/editor/checker
// Author: gre
// License: MIT

[[ stitchable ]] half4 checkerboard(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float tilesX,
                                    float tilesY) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Calculate checkerboard pattern
    float2 tileCoord = floor(float2(uv.x * tilesX, uv.y * tilesY));
    float checker = fmod(tileCoord.x + tileCoord.y, 2.0);
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask based on checkerboard pattern
    float mask = 0.0;
    
    if (checker < 0.5) {
        // White squares - reveal first half
        mask = smoothstep(0.0, 0.5, progress);
    } else {
        // Black squares - reveal second half
        mask = smoothstep(0.5, 1.0, progress);
    }
    
    return color * half(mask);
}
