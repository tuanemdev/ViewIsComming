#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Ported from https://github.com/gl-transitions/gl-transitions
// Author: 0gust1
// License: MIT

[[ stitchable ]] half4 simpleZoom(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float zoomQuickness) {
    // Normalize coordinates
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);
    
    // Clamp quickness to valid range
    float nQuick = clamp(zoomQuickness, 0.2, 1.0);
    
    // Calculate zoom amount with smoothstep
    float zoomAmount = smoothstep(0.0, nQuick, progress);
    
    // Zoom function: scale UV from center
    float2 zoomedUV = center + ((uv - center) * (1.0 - zoomAmount));
    
    // Sample with zoomed coordinates
    float2 zoomedPos = zoomedUV * size;
    
    // Bounds check
    bool inBounds = zoomedUV.x >= 0.0 && zoomedUV.x <= 1.0 && zoomedUV.y >= 0.0 && zoomedUV.y <= 1.0;
    
    half4 color = inBounds ? layer.sample(zoomedPos) : half4(0.0);
    
    // Calculate fade-out mask
    float fadeMask = smoothstep(nQuick - 0.2, 1.0, progress);
    
    // Combine zoom and fade: at progress=0 fully visible, at progress=1 zoomed and faded out
    float mask = 1.0 - fadeMask;
    
    return color * half(mask);
}
