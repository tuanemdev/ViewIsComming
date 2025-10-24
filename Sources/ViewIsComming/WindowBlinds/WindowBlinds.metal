#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: Fabien Benetou
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/windowblinds.glsl

[[ stitchable ]] half4 windowBlinds(float2 position,
                                    SwiftUI::Layer layer,
                                    float2 size,
                                    float progress) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float t = progress;
    
    if (fmod(floor(uv.y * 100.0 * progress), 2.0) == 0.0)
        t *= 2.0 - 0.5;
    
    // Calculate mask
    float mask = mix(t, progress, smoothstep(0.8, 1.0, progress));
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
