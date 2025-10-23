#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// MultiplyBlend - Multiply blend mode transition
// Ported from: https://gl-transitions.com/editor/Multiply_Blend_Transition
// Author: Xaychru
// License: MIT

[[ stitchable ]] half4 multiplyBlend(float2 position,
                                     SwiftUI::Layer layer,
                                     float2 size,
                                     float progress,
                                     float intensity) {
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Create blend color (darkening effect)
    half3 blendColor = half3(progress);
    
    // Multiply blend mode
    half3 multiplied = color.rgb * blendColor;
    
    // Mix between original and multiplied based on intensity
    half3 finalColor = mix(color.rgb, multiplied, half(intensity * (1.0 - progress)));
    
    // Apply mask
    float mask = progress;
    
    return half4(finalColor, color.a) * half(mask);
}
