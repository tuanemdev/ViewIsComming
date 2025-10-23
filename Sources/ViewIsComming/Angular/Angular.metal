#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 angular(float2 position,
                               SwiftUI::Layer layer,
                               float2 size,
                               float progress,
                               float startingAngle,
                               float clockwise) {
    // Normalize coordinates to [0, 1]
    float2 uv = position / size;
    
    // Convert starting angle from degrees to radians
    // Negate the angle to fix the direction mapping
    // 0° = right, 90° = top, 180° = left, 270° = bottom
    float offset = -startingAngle * 3.141592653589 / 180.0;
    
    // Calculate angle from center (0.5, 0.5)
    // In Metal: atan2(y, x) is same as GLSL atan(y, x)
    float angle = atan2(uv.y - 0.5, uv.x - 0.5) + offset;
    
    // Normalize angle to [0, 1] range
    // Original: (angle + PI) / (2.0 * PI)
    float normalizedAngle = (angle + 3.141592653589) / (2.0 * 3.141592653589);
    
    // Keep only fractional part (handles wrapping)
    normalizedAngle = normalizedAngle - floor(normalizedAngle);
    
    // Reverse direction if counter-clockwise (clockwise = 0)
    if (clockwise < 0.5) {
        normalizedAngle = 1.0 - normalizedAngle;
    }
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask: when normalizedAngle < progress, show (mask = 1)
    // step(normalizedAngle, progress) returns 1.0 when normalizedAngle <= progress
    float mask = step(normalizedAngle, progress);
    
    return color * half(mask);
}
