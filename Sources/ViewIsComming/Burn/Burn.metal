#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
#include "../Constants.metal"
using namespace metal;

[[ stitchable ]]
half4 burn(float2 position,
           SwiftUI::Layer layer,
           float2 size,
           float progress,
           float3 color) {
    // Sample the original pixel color from the view
    half4 sampledColor = layer.sample(position);
    // Calculate burn intensity using sine curve for smooth easing
    float burnIntensity = 1.0 - sin(progress * PI / 2.0);
    // Create the burn color by multiplying the input color with intensity
    half3 burnColor = half3(color) * half(burnIntensity);
    // Add the burn color to the original image color (additive blending)
    sampledColor.rgb += burnColor;
    // Apply alpha mask for transition visibility
    sampledColor.a *= half(progress);
    
    return sampledColor;
}
