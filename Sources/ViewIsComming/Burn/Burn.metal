#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[stitchable]] half4 burn(float2 position,
                           SwiftUI::Layer layer,
                           float2 size,
                           float progress,
                           float3 color) {
    half4 sampledColor = layer.sample(position);
    
    // Add burn color that fades in and out during transition
    // At progress 0 and 1: no burn effect
    // At progress 0.5: maximum burn effect
    float burnIntensity = sin(progress * 3.14159265359);
    half3 burnColor = half3(color) * half(burnIntensity);
    
    // Add burn color to the sampled color
    sampledColor.rgb += burnColor;
    
    // Apply alpha mask for transition
    // For SwiftUI: progress 0 = hidden, progress 1 = visible
    sampledColor.a *= half(progress);
    
    return sampledColor;
}
