#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: Ben Lucas
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/StaticFade.glsl

float staticFade_rnd(float2 st) {
    return fract(sin(dot(st, float2(10.5302340293, 70.23492931))) * 12345.5453123);
}

float4 staticFade_staticNoise(float2 st, float offset, float luminosity) {
    float staticR = luminosity * staticFade_rnd(st * float2(offset * 2.0, offset * 3.0));
    float staticG = luminosity * staticFade_rnd(st * float2(offset * 3.0, offset * 5.0));
    float staticB = luminosity * staticFade_rnd(st * float2(offset * 5.0, offset * 7.0));
    return float4(staticR, staticG, staticB, 1.0);
}

float staticFade_staticIntensity(float t) {
    float transitionProgress = abs(2.0 * (t - 0.5));
    return 1.0 - (1.0 - smoothstep(0.0, 0.5, transitionProgress)) * (1.0 - smoothstep(0.5, 1.0, transitionProgress));
}

[[ stitchable ]] half4 staticFade(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float nNoisePixels,
                                  float staticLuminosity) {
    // Normalize coordinates
    float2 uv = position / size;
    
    float2 st = floor(uv * float2(nNoisePixels)) / float2(nNoisePixels);
    float offset = progress;
    float intensity = staticFade_staticIntensity(progress);
    
    float4 staticColor = staticFade_staticNoise(st, offset, staticLuminosity);
    
    // Calculate mask
    float mask = mix(progress, intensity * staticColor.r + progress * (1.0 - intensity), intensity);
    
    // Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
