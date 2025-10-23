#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Morph transition
// Adapted from: https://gl-transitions.com/editor/morph
// Author: paniq
// License: MIT

[[ stitchable ]] half4 morph(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress,
                              float strength) {
    float2 uv = position / size;
    
    // Sample the layer at current position
    half4 color = layer.sample(position);
    
    // Calculate offset based on color channels
    // This creates a morphing distortion based on the image content
    float2 colorOffset = float2(color.rg) + float(color.b) * 0.5;
    colorOffset = colorOffset * 2.0 - 1.0;
    
    // Apply offset with strength
    float2 offset = colorOffset * strength;
    
    // Apply offset in the direction of transition
    float2 morphedUV = uv + offset * progress;
    
    // Clamp and sample
    float2 morphedPos = morphedUV * size;
    morphedPos = clamp(morphedPos, float2(0.0), size);
    
    half4 morphedColor = layer.sample(morphedPos);
    
    // Fade out as progress increases
    float mask = 1.0 - progress;
    
    return morphedColor * half(mask);
}
