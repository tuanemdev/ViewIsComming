#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: Rich Harris
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/perlin.glsl

// Perlin noise functions
float perlin_rand(float2 co) {
    return fract(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}

float2 perlin_fade(float2 t) {
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

float perlin_noise(float2 P, float seed) {
    float2 Pi = floor(P);
    float2 Pf = P - Pi;
    
    Pi = fmod(Pi, float2(289.0));
    float2 Pi_inc1 = Pi + float2(1.0);
    
    float n00 = perlin_rand(Pi + seed);
    float n10 = perlin_rand(float2(Pi_inc1.x, Pi.y) + seed);
    float n01 = perlin_rand(float2(Pi.x, Pi_inc1.y) + seed);
    float n11 = perlin_rand(Pi_inc1 + seed);
    
    float2 fade_xy = perlin_fade(Pf);
    
    float n_x = mix(mix(n00, n10, fade_xy.x), mix(n01, n11, fade_xy.x), fade_xy.y);
    return n_x;
}

[[ stitchable ]] half4 perlin(float2 position,
                              SwiftUI::Layer layer,
                              float2 size,
                              float progress,
                              float scale,
                              float smoothness,
                              float seed) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float n = perlin_noise(uv * scale, seed);
    
    // Calculate mask
    float mask = smoothstep(n - smoothness, n + smoothness, progress);
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
