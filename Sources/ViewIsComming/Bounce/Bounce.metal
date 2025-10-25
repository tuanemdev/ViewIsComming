#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
#include "../Constants.metal"
using namespace metal;

[[ stitchable ]]
half4 bounce(float2 position,
             SwiftUI::Layer layer,
             float2 size,
             float progress,
             float bounces,
             float isInsertion) {
    // Normalize coordinates
    float2 uv = position / size;
    // Calculate bounce position
    float stime = sin(progress * PI / 2.0);
    float phase = progress * PI * bounces;
    float y = abs(cos(phase)) * (1.0 - stime);
    // Calculate sample UV based on direction
    float2 sampleUV;
    if (isInsertion > 0.5) {
        // Insertion: View drops from above and bounces at bottom
        // Shift UVs so bottom of view is at (1.0 - y)
        sampleUV = float2(uv.x, uv.y + y);
    } else {
        // Removal: View top bounces at bottom while sliding down
        // SwiftUI flipped: sample from (uv.y - 1.0 + y)
        sampleUV = float2(uv.x, uv.y - 1.0 + y);
    }
    
    half4 color = half4(0.0);
    // Sample if in bounds
    if (sampleUV.y >= 0.0 && sampleUV.y <= 1.0) {
        color = layer.sample(sampleUV * size);
    }
    return color;
}
