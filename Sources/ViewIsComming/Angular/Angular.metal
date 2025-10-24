#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 angular(float2 position,
                               SwiftUI::Layer layer,
                               float2 size,
                               float progress,
                               float startingAngle,
                               float clockwise) {
    // PI constant
    const float PI = 3.141592653589;
    // Normalize coordinates to [0, 1]
    float2 uv = position / size;
    // Calculate vector from center (0.5, 0.5) to current position
    float2 dir = float2(uv.x - 0.5, uv.y - 0.5);
    // Calculate angle in standard polar coordinates
    // 0° = right, 90° = up, 180° = left, 270° = down
    float angle = atan2(-dir.y, -dir.x);
    // Apply starting angle offset (convert from degrees to radians)
    // Add offset instead of subtract to rotate the coordinate system
    float offset = startingAngle * PI / 180.0;
    angle = angle + offset;
    // Normalize angle to [0, 1] range
    float normalizedAngle = (angle + PI) / (2.0 * PI);
    // Keep only fractional part (handles wrapping)
    normalizedAngle = normalizedAngle - floor(normalizedAngle);
    // Counter-clockwise: reverse the direction
    if (clockwise < 0.5) {
        normalizedAngle = 1.0 - normalizedAngle;
    }
    // Sample the layer
    half4 color = layer.sample(position);
    // Calculate mask: when normalizedAngle < progress
    float mask = step(normalizedAngle, progress);
    
    return color * half(mask);
}
