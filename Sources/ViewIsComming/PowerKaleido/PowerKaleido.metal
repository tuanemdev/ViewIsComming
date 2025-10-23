#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// PowerKaleido - Powerful kaleidoscope effect
// Ported from: https://gl-transitions.com/editor/kaleidoscope
// Author: nwoeanhinnogaehr
// License: MIT

[[ stitchable ]] half4 powerKaleido(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float speed,
                                    float angle,
                                    float power) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Center coordinates
    float2 centered = uv - 0.5;
    
    // Calculate angle and radius
    float theta = atan2(centered.y, centered.x);
    float radius = length(centered);
    
    // Apply kaleidoscope effect
    float segments = power * 2.0;
    float angleSegment = 6.28318530718 / segments; // 2*PI / segments
    
    // Fold the angle
    theta = fmod(theta, angleSegment);
    if (theta < 0.0) theta += angleSegment;
    
    // Mirror every other segment
    float segmentIndex = floor((atan2(centered.y, centered.x) + 3.14159265359) / angleSegment);
    if (int(segmentIndex) % 2 == 1) {
        theta = angleSegment - theta;
    }
    
    // Rotate based on progress
    theta += angle * 3.14159265359 / 180.0 + progress * speed;
    
    // Convert back to cartesian
    float2 kaleidoUV = float2(cos(theta), sin(theta)) * radius + 0.5;
    
    // Sample the layer
    half4 color = layer.sample(kaleidoUV * size);
    
    // Apply mask
    float mask = progress;
    
    return color * half(mask);
}
