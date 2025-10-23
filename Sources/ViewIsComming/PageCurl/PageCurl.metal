#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// PageCurl - Page curl effect
// Ported from: https://gl-transitions.com/editor/pagecurl
// Author: Andrew Hung
// License: MIT

[[ stitchable ]] half4 pageCurl(float2 position,
                                SwiftUI::Layer layer,
                                float2 size,
                                float progress,
                                float angle,
                                float radius) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Convert angle to radians
    float rad = angle * 3.14159265359 / 180.0;
    float2 dir = float2(cos(rad), sin(rad));
    
    // Calculate distance from curl line
    float dist = dot(uv - float2(0.5), dir) + progress - 0.5;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask based on curl
    float mask = 1.0;
    
    if (dist > 0.0) {
        // In the curled region
        float curlAmount = smoothstep(0.0, radius, dist);
        
        // Calculate shadow effect
        float shadow = 1.0 - curlAmount * 0.5;
        
        // Fade out the curled portion
        mask = 1.0 - curlAmount;
        
        // Apply shadow to visible part
        color = color * half(shadow);
    }
    
    return color * half(mask);
}
