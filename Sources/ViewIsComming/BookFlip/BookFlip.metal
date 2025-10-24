#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

float2 bookFlipSkew(float2 p, float progress) {
    float skewX = (p.x - 0.5) / (progress - 0.5) * 0.5 + 0.5;
    float skewY = (p.y - 0.5) / (0.5 + (1.0 - progress) * (0.5 - p.x) / 0.5) * 0.5 + 0.5;
    return float2(skewX, skewY);
}

[[ stitchable ]]
half4 bookFlip(float2 position,
               SwiftUI::Layer layer,
               float2 size,
               float progress,
               float flipRight) {
    // PI constant
    const float PI = 3.141592653589;
    // Normalize coordinates to [0, 1]
    float2 uv = position / size;
    // Mirror UV for left flip
    bool isFlipRight = flipRight > 0.5;
    float2 workingUV = isFlipRight ? uv : float2(1.0 - uv.x, uv.y);
    float pr = step(1.0 - progress, workingUV.x);
    float2 sampleUV;
    float mask;
    // Default: no shading
    float shade = 1.0;
    if (workingUV.x < 0.5) {
        // First half: appears with skew effect (3D part)
        float2 skewed = bookFlipSkew(workingUV, progress);
        // Un-mirror for left flip
        sampleUV = isFlipRight ? skewed : float2(1.0 - skewed.x, skewed.y);
        // Apply shading: darkest at progress= 0.5 (closest to viewer), brightest at 0 and 1
        // Using sine wave: bright at edges, dark in middle
        float shadeFactor = sin(progress * PI);
        // Range: 1.0 (bright) to 0.6 (darker)
        shade = 1.0 - (shadeFactor * 0.4);
        // Check bounds - if skewed UV is out of bounds, hide it
        if (progress < 0.5) {
            mask = 0.0;
        } else {
            mask = pr;
        }
    } else {
        // Second half: appears normal (not skewed)
        sampleUV = uv;
        mask = pr;
    }
    
    half4 color = layer.sample(sampleUV * size);
    return color * half(mask * shade);
}
