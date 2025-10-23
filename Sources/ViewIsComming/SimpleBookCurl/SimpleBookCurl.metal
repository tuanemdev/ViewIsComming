#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// SimpleBookCurl - Simple book page curl
// Ported from: https://gl-transitions.com/editor/BookCurl
// Author: Raymond Luckhurst
// License: MIT

[[ stitchable ]] half4 simpleBookCurl(float2 position,
                                      SwiftUI::Layer layer,
                                      float2 size,
                                      float progress,
                                      float curlAmount,
                                      float radius) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Calculate curl position (moves from right to left)
    float curlPos = 1.0 - progress;
    
    // Distance from curl position
    float dist = uv.x - curlPos;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask
    float mask = 1.0;
    
    if (dist > 0.0) {
        // In the curled region
        float curl = smoothstep(0.0, radius, dist);
        
        // Create curl effect with shadow
        float shadow = 1.0 - curl * curlAmount;
        
        // Fade out the page
        mask = 1.0 - curl;
        
        // Apply shadow
        color = color * half(shadow);
    } else {
        // Not curled yet - add slight shadow as curl approaches
        float preShadow = smoothstep(-radius, 0.0, dist);
        float shadowAmount = preShadow * 0.3;
        color = color * half(1.0 - shadowAmount);
    }
    
    return color * half(mask);
}
