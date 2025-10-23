#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// GlitchDisplace - Glitch displacement effect
// Ported from: https://gl-transitions.com/editor/GlitchDisplace
// Author: Matt DesLauriers
// License: MIT

// Helper: Noise function
float glitchDisplace_noise(float2 co) {
    return fract(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 glitchDisplace(float2 position,
                                      SwiftUI::Layer layer,
                                      float2 size,
                                      float progress,
                                      float intensity,
                                      float frequency) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Create glitch displacement
    float glitchAmount = progress * intensity;
    
    // Horizontal displacement based on vertical position
    float disp = glitchDisplace_noise(float2(floor(uv.y * frequency), progress * 10.0)) - 0.5;
    
    // Apply displacement
    float2 displacedUV = uv;
    displacedUV.x += disp * glitchAmount;
    
    // Sample the layer at displaced position
    float2 samplePos = displacedUV * size;
    half4 color = layer.sample(samplePos);
    
    // Calculate mask
    float mask = smoothstep(0.0, 1.0, progress);
    
    // Add glitch color separation
    if (abs(disp) > 0.3) {
        // RGB split effect on strong glitches
        float offset = glitchAmount * 0.05;
        half4 rColor = layer.sample((displacedUV + float2(offset, 0.0)) * size);
        half4 bColor = layer.sample((displacedUV - float2(offset, 0.0)) * size);
        color = half4(rColor.r, color.g, bColor.b, color.a);
    }
    
    return color * half(mask);
}
