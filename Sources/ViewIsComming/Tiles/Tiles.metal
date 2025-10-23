#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Tiles - Tile-based transition
// Ported from: https://gl-transitions.com/editor/randomsquares
// Author: gre
// License: MIT

// Helper: Simple rand function
float tiles_rand(float2 co) {
    return fract(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 tiles(float2 position,
                             SwiftUI::Layer layer,
                             float2 size,
                             float progress,
                             float tilesX,
                             float tilesY) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Calculate tile coordinates
    float2 tileCoord = float2(floor(uv.x * tilesX), floor(uv.y * tilesY));
    
    // Random value for this tile
    float randomValue = tiles_rand(tileCoord);
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask based on random tile timing
    float tileProgress = smoothstep(randomValue - 0.3, randomValue, progress);
    
    float mask = tileProgress;
    
    return color * half(mask);
}
