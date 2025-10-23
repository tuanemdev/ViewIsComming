#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// WipeUp: wipes from bottom to top
[[stitchable]] half4 wipeUp(float2 position,
                             SwiftUI::Layer layer,
                             float2 size,
                             float progress) {
    float2 uv = position / size;
    
    // For SwiftUI: progress 0 = hidden, progress 1 = visible
    // step returns 1 if uv.y >= progress, 0 otherwise
    float mask = step(progress, uv.y);
    
    half4 color = layer.sample(position);
    return color * half(mask);
}

// WipeDown: wipes from top to bottom
[[stitchable]] half4 wipeDown(float2 position,
                               SwiftUI::Layer layer,
                               float2 size,
                               float progress) {
    float2 uv = position / size;
    
    // Inverted from wipeUp
    float mask = step(progress, 1.0 - uv.y);
    
    half4 color = layer.sample(position);
    return color * half(mask);
}

// WipeLeft: wipes from right to left
[[stitchable]] half4 wipeLeft(float2 position,
                               SwiftUI::Layer layer,
                               float2 size,
                               float progress) {
    float2 uv = position / size;
    
    float mask = step(progress, 1.0 - uv.x);
    
    half4 color = layer.sample(position);
    return color * half(mask);
}

// WipeRight: wipes from left to right
[[stitchable]] half4 wipeRight(float2 position,
                                SwiftUI::Layer layer,
                                float2 size,
                                float progress) {
    float2 uv = position / size;
    
    float mask = step(progress, uv.x);
    
    half4 color = layer.sample(position);
    return color * half(mask);
}
