#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// ZoomInCircles - Zoom in circles pattern
// Ported from: https://gl-transitions.com/editor/ZoomInCircles
// Author: dycm8009
// License: MIT

[[ stitchable ]] half4 zoomInCircles(float2 position,
                                     SwiftUI::Layer layer,
                                     float2 size,
                                     float progress,
                                     float speed,
                                     float density) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate distance from center
    float dist = length(centered);
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask based on circles and progress
    float mask = 1.0;
    
    // Create circular reveal pattern
    float threshold = progress * density;
    float circleMask = step(dist * density, threshold);
    
    // Smooth the edges
    float edge = smoothstep(threshold - 0.5, threshold, dist * density);
    
    mask = circleMask + (1.0 - circleMask) * (1.0 - edge);
    
    return color * half(mask);
}
