#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// StereoViewer - Stereo viewer effect
// Ported from: https://gl-transitions.com/editor/StereoViewer
// Author: Ted Schundler
// License: MIT

[[ stitchable ]] half4 stereoViewer(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float zoom,
                                    float cornerRadius) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Calculate stereo effect
    float zoomAmount = zoom * progress;
    
    // Split screen effect
    float side = step(0.5, uv.x);
    
    // Apply zoom from corners
    float2 centered = uv - float2(side * 0.5 + 0.25, 0.5);
    float2 zoomed = centered / (1.0 - zoomAmount);
    float2 finalUV = zoomed + float2(side * 0.5 + 0.25, 0.5);
    
    // Sample the layer
    half4 color = layer.sample(finalUV * size);
    
    // Calculate corner radius mask
    float2 toCorner = abs(centered);
    float cornerDist = length(max(toCorner - float2(0.25 - cornerRadius, 0.5 - cornerRadius), 0.0));
    float cornerMask = 1.0 - smoothstep(cornerRadius * (1.0 - progress), cornerRadius, cornerDist);
    
    // Calculate mask
    float mask = progress;
    
    // Check bounds
    if (finalUV.x < side * 0.5 || finalUV.x > side * 0.5 + 0.5 || 
        finalUV.y < 0.0 || finalUV.y > 1.0) {
        mask = 0.0;
    }
    
    mask *= cornerMask;
    
    return color * half(mask);
}
