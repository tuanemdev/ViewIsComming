#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: pthrasher
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/undulatingBurnOut.glsl

#define M_PI 3.14159265358979323846

float undulatingBurnOut_quadraticInOut(float t) {
    float p = 2.0 * t * t;
    return t < 0.5 ? p : -p + (4.0 * t) - 1.0;
}

float undulatingBurnOut_getGradient(float r, float dist, float smoothness) {
    float d = r - dist;
    return mix(
        smoothstep(-smoothness, 0.0, r - dist * (1.0 + smoothness)),
        -1.0 - step(0.005, d),
        step(-0.005, d) * step(d, 0.01)
    );
}

float undulatingBurnOut_getWave(float2 p, float smoothness, float2 center) {
    float2 _p = p - center;
    float rads = atan2(_p.y, _p.x);
    float degs = (rads * 180.0 / M_PI) + 180.0;  // Convert radians to degrees
    float ratio = (M_PI * 2.0) / 360.0;
    degs = degs * ratio;
    float x = degs;
    float magnitude = abs(cos(x * cos(x))) * smoothness;
    return magnitude;
}

[[ stitchable ]] half4 undulatingBurnOut(float2 position,
                                         SwiftUI::Layer layer,
                                         float2 size,
                                         float progress,
                                         float smoothness,
                                         float2 center) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float2 p = uv;
    float dist = distance(center, p);
    float m = undulatingBurnOut_getGradient(undulatingBurnOut_getWave(p, smoothness, center), dist, smoothness);
    
    float mask = step(m, -2.0) ? 0.0 : progress;
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
