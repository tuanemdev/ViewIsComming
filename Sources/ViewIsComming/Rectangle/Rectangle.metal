#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Ported from https://github.com/gl-transitions/gl-transitions
// Author: martiniti
// License: MIT

[[ stitchable ]] half4 rectangle(float2 position,
                                 SwiftUI::Layer layer,
                                 float2 size,
                                 float progress) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Calculate shrink amount - more dramatic in the middle
    float s = pow(2.0 * abs(progress - 0.5), 3.0);
    
    // Calculate rectangle bounds based on progress
    float edgeDistance = abs(1.0 - 2.0 * progress);
    
    // Bottom-left corner check
    float2 bl = step(float2(edgeDistance), uv + 0.25);
    float blMask = bl.x * bl.y;
    
    // Top-right corner check
    float2 tr = step(float2(edgeDistance), 1.25 - uv);
    float trMask = tr.x * tr.y;
    
    // Combined mask: inside rectangle if both corners pass
    float insideRect = blMask * trMask;
    
    // Apply s threshold for smooth transition
    float dist = 1.0 - insideRect;
    float alpha = step(s, dist);
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Determine visibility based on progress phase
    float mask;
    if (progress < 0.5) {
        // First half: showing original view, shrinking rectangle reveals it
        mask = 1.0 - alpha;
    } else {
        // Second half: view should be fully visible
        mask = 1.0;
    }
    
    // For transition, we want: 0.0 = hidden, 1.0 = visible
    // At progress=0: fully visible
    // At progress=0.5: smallest rectangle (most hidden)
    // At progress=1.0: fully visible again
    
    // Adjust mask to work with transition semantics
    float finalMask = (progress < 0.5) ? (1.0 - alpha) : alpha;
    finalMask = mix(0.0, 1.0, finalMask);
    
    return color * half(finalMask);
}
