#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Ported from https://github.com/gl-transitions/gl-transitions
// License: MIT
// Author: P-Seebauer
// ported by gre from https://gist.github.com/P-Seebauer/2a5fa2f77c883dd661f9

[[ stitchable ]] half4 colourDistance(float2 position,
                                      SwiftUI::Layer layer,
                                      float2 size,
                                      float progress,
                                      float power) {
    // Sample the layer color
    half4 color = layer.sample(position);
    
    // In the original GLSL, this compares fromColor with toColor
    // For a single-view transition, we use a reference color (black or white)
    // and compare the current pixel color distance to it
    
    // Reference color for comparison (using a mid-gray as neutral point)
    half4 referenceColor = half4(0.5, 0.5, 0.5, 1.0);
    
    // Calculate color distance
    float dist = distance(float4(color), float4(referenceColor));
    
    // Threshold based on progress
    // Areas with color distance < progress fade out first
    float threshold = progress * 0.5; // Scale down for smoother transition
    float m = step(dist, threshold);
    
    // Mix between original color and faded
    float baseMask = 1.0 - m;
    
    // Apply power curve for non-linear fading
    float mask = mix(baseMask, 1.0 - progress, pow(progress, power));
    
    return color * half(mask);
}
