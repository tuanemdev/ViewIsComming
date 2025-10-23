#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Author: TimDonselaar
// License: MIT
// Ported from: https://github.com/gl-transitions/gl-transitions/blob/master/transitions/GridFlip.glsl

#define PI 3.14159265359

float gridFlip_rand(float2 co) {
    return fract(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}

float gridFlip_getDelta(float2 p, int2 size, float pause, float randomness) {
    float2 rectanglePos = floor(float2(size) * p);
    float2 rectangleSize = float2(1.0 / float(size.x), 1.0 / float(size.y));
    float top = rectangleSize.y * (rectanglePos.y + 1.0);
    float bottom = rectangleSize.y * rectanglePos.y;
    float left = rectangleSize.x * rectanglePos.x;
    float right = rectangleSize.x * (rectanglePos.x + 1.0);
    float minX = min(abs(p.x - left), abs(p.x - right));
    float minY = min(abs(p.y - top), abs(p.y - bottom));
    return min(minX, minY) + gridFlip_rand(rectanglePos) * randomness;
}

float gridFlip_getDividerSize(float2 p, int2 size, float pause, float randomness) {
    float2 rectanglePos = floor(float2(size) * p);
    return pause + gridFlip_rand(rectanglePos) * randomness;
}

[[ stitchable ]] half4 gridFlip(float2 position,
                                SwiftUI::Layer layer,
                                float2 size,
                                float progress,
                                float2 gridSize,
                                float pause,
                                float dividerWidth,
                                float randomness) {
    // Normalize coordinates
    float2 uv = position / size;
    
    int2 isize = int2(gridSize);
    
    if (progress < pause) {
        float currentProg = progress / pause;
        float delta = gridFlip_getDelta(uv, isize, pause, randomness);
        float mask = step(delta, currentProg);
        
        half4 color = layer.sample(position);
        return color * half(1.0 - mask);
    } else if (progress < 1.0 - pause) {
        float mask = 0.0;
        if (gridFlip_getDividerSize(uv, isize, pause, randomness) > 0.0) {
            mask = 1.0;
        }
        
        half4 color = layer.sample(position);
        return color * half(mask);
    } else {
        float currentProg = (progress - 1.0 + pause) / pause;
        float delta = gridFlip_getDelta(uv, isize, pause, randomness);
        float mask = step(currentProg, delta);
        
        half4 color = layer.sample(position);
        return color * half(mask);
    }
}
