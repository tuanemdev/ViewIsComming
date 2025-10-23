#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[stitchable]] half4 ripple(float2 position,
                             SwiftUI::Layer layer,
                             float2 size,
                             float progress,
                             float amplitude,
                             float speed) {
    float2 uv = position / size;
    
    // Calculate direction and distance from center
    float2 dir = uv - float2(0.5);
    float dist = length(dir);
    
    // Create ripple offset
    float rippleOffset = (sin(progress * dist * amplitude - progress * speed) + 0.5) / 30.0;
    float2 offset = dir * rippleOffset;
    
    // Sample with offset
    float2 samplePos = position + offset * size;
    half4 color = layer.sample(samplePos);
    
    // Apply fade transition using smoothstep
    // For SwiftUI: progress 0 = hidden, progress 1 = visible
    float mask = smoothstep(0.2, 1.0, progress);
    
    return color * half(mask);
}
