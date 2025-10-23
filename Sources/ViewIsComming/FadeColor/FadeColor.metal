#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[stitchable]] half4 fadeColor(float2 position,
                                 SwiftUI::Layer layer,
                                 float2 size,
                                 float progress,
                                 float3 color,
                                 float colorPhase) {
    half4 sampledColor = layer.sample(position);
    half3 fadeColor = half3(color);
    
    // For SwiftUI transition:
    // progress 0 = hidden (fade to color)
    // progress 1 = visible (show original)
    
    // Calculate how much to mix with the fade color
    // colorPhase controls how prominent the color phase is
    float colorMix;
    
    if (progress < 0.5) {
        // First half: fade from original to color
        colorMix = smoothstep(0.0, colorPhase, progress * 2.0);
    } else {
        // Second half: fade from color to original
        colorMix = 1.0 - smoothstep(1.0 - colorPhase, 1.0, (progress - 0.5) * 2.0);
    }
    
    // Mix the sampled color with the fade color
    half3 result = mix(sampledColor.rgb, fadeColor, half(colorMix));
    
    // Apply overall alpha based on progress
    half alpha = half(progress);
    
    return half4(result, sampledColor.a * alpha);
}
