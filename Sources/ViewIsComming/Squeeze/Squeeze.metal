#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Squeeze transition
// Adapted from: https://gl-transitions.com/editor/squeeze
// Author: gre
// License: MIT

[[ stitchable ]] half4 squeeze(float2 position,
                                SwiftUI::Layer layer,
                                float2 size,
                                float progress,
                                float colorSeparation) {
    float2 uv = position / size;
    
    // Squeeze effect - compress from both sides
    // The image gets squeezed horizontally as it transitions
    float squeezeAmount = 1.0 - progress;
    
    // Calculate the squeeze factor (how much to compress)
    float t = 0.5 - abs(progress - 0.5);
    
    // Chromatic aberration color separation during squeeze
    float y = 0.5 + (uv.y - 0.5) / (1.0 - t);
    
    // Check if we're outside the squeezed region
    if (y < 0.0 || y > 1.0) {
        return half4(0.0);
    }
    
    // Calculate position with squeeze
    float2 squeezedPos = position;
    squeezedPos.y = y * size.y;
    
    // Add color separation effect
    half4 color = half4(0.0);
    
    // Sample red with slight offset
    float2 redPos = squeezedPos;
    redPos.y += colorSeparation * t * size.y;
    redPos = clamp(redPos, float2(0.0), size);
    color.r = layer.sample(redPos).r;
    
    // Sample green normally
    color.g = layer.sample(squeezedPos).g;
    
    // Sample blue with opposite offset
    float2 bluePos = squeezedPos;
    bluePos.y -= colorSeparation * t * size.y;
    bluePos = clamp(bluePos, float2(0.0), size);
    color.b = layer.sample(bluePos).b;
    
    // Alpha is based on whether we're in the transition
    color.a = half(squeezeAmount > 0.0 ? 1.0 : 0.0);
    
    // Fade based on progress
    float mask = 1.0 - progress;
    
    return color * half(mask);
}
