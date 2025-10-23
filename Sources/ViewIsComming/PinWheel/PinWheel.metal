#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 pinWheel(float2 position,
                                SwiftUI::Layer layer,
                                float2 size,
                                float progress,
                                float speed) {
    float2 uv = position / size;
    float2 p = uv;
    
    // Calculate circular position using atan2
    // In GLSL: atan(y, x) - same as Metal's atan2(y, x)
    float circPos = atan2(p.y - 0.5, p.x - 0.5) + progress * speed;
    
    // Calculate modulo position
    // Use fmod to handle negative angles properly
    float modPos = fmod(circPos, 3.1415926 / 4.0);
    
    // Normalize modPos to always be positive for comparison
    // This fixes the issue at angles from 9h to 1h (negative angles)
    if (modPos < 0.0) {
        modPos += 3.1415926 / 4.0;
    }
    
    // Calculate signed value - match GLSL logic
    // In original: sign(progress - modPos)
    // When progress = 1 and modPos is small (close to 0), sign(1 - 0) = +1
    // When progress = 0 and modPos is any value, sign(0 - modPos) = -1
    float signedValue = sign(progress - modPos);
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Apply the pinwheel mask using step function
    // step(signedValue, 0.5) returns 1.0 when signedValue <= 0.5
    // When signedValue = +1 (progress high), step(1, 0.5) = 0
    // When signedValue = -1 (progress low), step(-1, 0.5) = 1
    // So we need to invert: 1.0 - step()
    float mask = 1.0 - step(signedValue, 0.5);
    
    return color * half(mask);
}
