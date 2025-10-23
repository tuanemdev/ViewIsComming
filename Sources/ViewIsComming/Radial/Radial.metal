#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[stitchable]] half4 radial(float2 position,
                             SwiftUI::Layer layer,
                             float2 size,
                             float progress,
                             float smoothness) {
    // Normalize coordinates to [0,1]
    float2 uv = position / size;
    
    // Convert to centered coordinates [-1, 1]
    float2 rp = uv * 2.0 - 1.0;
    
    // Calculate angle using atan2 (y, x)
    // The angle will be in range [-PI, PI]
    float angle = atan2(rp.y, rp.x);
    
    // Calculate threshold for this pixel
    // progress ranges from 0 to 1
    // When progress = 0: threshold is very negative, so everything is visible (from)
    // When progress = 1: threshold is very positive, so everything is hidden (to)
    const float PI = 3.141592653589;
    float threshold = (progress - 0.5) * PI * 2.5;
    
    // Calculate mask using smoothstep
    // If angle > threshold: mask = 1 (show TO color)
    // If angle < threshold: mask = 0 (show FROM color)
    float mask = smoothstep(0.0, smoothness, angle - threshold);
    
    // Sample color
    half4 color = layer.sample(position);
    
    // For SwiftUI transitions:
    // progress = 0 (inserted/appearing): we want mask = 0 (hidden)
    // progress = 1 (identity/visible): we want mask = 1 (visible)
    // So we need to flip the logic from the original GLSL
    
    // Invert mask for SwiftUI transition
    mask = 1.0 - mask;
    
    return color * half(mask);
}
