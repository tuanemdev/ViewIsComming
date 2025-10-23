#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: nwoeanhinnogaehr
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/kaleidoscope.glsl

#define PI 3.14159265358979323846264

[[ stitchable ]] half4 kaleidoscope(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress,
                                    float speed,
                                    float angle,
                                    float power) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float2 p = uv - 0.5;
    float dist = length(p);
    float theta = atan2(p.y, p.x);
    
    float t = progress * speed;
    theta += angle * sin(t);
    
    // Kaleidoscope effect
    float segments = power;
    float segmentAngle = 2.0 * PI / segments;
    theta = fmod(theta, segmentAngle);
    
    if (fmod(floor(atan2(p.y, p.x) / segmentAngle), 2.0) == 0.0) {
        theta = segmentAngle - theta;
    }
    
    float2 newP = dist * float2(cos(theta), sin(theta)) + 0.5;
    
    // Calculate mask
    float mask = smoothstep(0.0, 1.0, progress);
    
    // Sample and apply mask
    half4 color = layer.sample(newP * size);
    return color * half(mask);
}
