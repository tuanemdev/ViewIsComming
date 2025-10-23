#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// DoomScreen - Doom screen melt effect
// Ported from: https://gl-transitions.com/editor/DoomScreenTransition
// Author: Zeh Fernando
// License: MIT

// Helper function for doom random
float doomScreen_rand(float2 co) {
    return fract(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 doomScreen(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float barsFloat,
                                  float amplitude,
                                  float noise,
                                  float frequency) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Cast float to int for bars
    int bars = int(barsFloat);
    
    // Calculate bar index
    int barIndex = int(floor(uv.x * float(bars)));
    float barX = float(barIndex) / float(bars);
    
    // Random offset for each bar
    float randomOffset = doomScreen_rand(float2(barX, 0.0));
    
    // Calculate melt offset
    float meltProgress = progress + randomOffset * noise;
    meltProgress = clamp(meltProgress, 0.0, 1.0);
    
    // Sine wave modulation
    float wave = sin(barX * frequency) * amplitude;
    
    // Apply vertical displacement
    float displacement = meltProgress * (1.0 + wave);
    
    // Distort UV
    float2 distortedUV = uv;
    distortedUV.y -= displacement;
    
    // Sample the layer
    half4 color = layer.sample(distortedUV * size);
    
    // Calculate mask
    float mask = progress;
    
    // Fade out melted areas
    if (distortedUV.y < 0.0) {
        mask = 0.0;
    }
    
    return color * half(mask);
}
