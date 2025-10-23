#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// VHS - VHS tape glitch effect
// Custom implementation

// Helper function for VHS noise
float vhs_noise(float2 p) {
    return fract(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
}

[[ stitchable ]] half4 vhs(float2 position,
                          SwiftUI::Layer layer,
                          float2 size,
                          float progress,
                          float glitchAmount,
                          float lineHeight) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // VHS scanline effect
    float scanline = floor(uv.y / lineHeight);
    float noise = vhs_noise(float2(scanline, progress * 100.0));
    
    // Horizontal displacement
    float displacement = (noise - 0.5) * glitchAmount * (1.0 - progress);
    
    // Apply displacement
    float2 distortedUV = uv;
    distortedUV.x += displacement;
    
    // RGB shift for glitch effect
    float shift = glitchAmount * 0.01 * (1.0 - progress);
    half4 colorR = layer.sample((distortedUV + float2(shift, 0.0)) * size);
    half4 colorG = layer.sample(distortedUV * size);
    half4 colorB = layer.sample((distortedUV - float2(shift, 0.0)) * size);
    
    half4 color = half4(colorR.r, colorG.g, colorB.b, 1.0);
    
    // Add scanline darkness
    float scanlineDark = fmod(uv.y, lineHeight) < lineHeight * 0.5 ? 0.9 : 1.0;
    color *= half(scanlineDark);
    
    // Apply mask
    float mask = progress;
    
    // Check bounds
    if (distortedUV.x < 0.0 || distortedUV.x > 1.0) {
        mask *= 0.5; // Partially visible for glitch effect
    }
    
    return color * half(mask);
}
