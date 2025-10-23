#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[stitchable]] half4 circleCrop(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float3 bgColor) {
    float2 uv = position / size;
    
    // Adjust for aspect ratio
    float ratio = size.x / size.y;
    float2 ratio2 = float2(1.0, 1.0 / ratio);
    
    // Calculate distance from center
    float dist = length((uv - 0.5) * ratio2);
    
    // Calculate radius based on progress
    // Use cubic easing for smoother effect
    float s = pow(2.0 * abs(progress - 0.5), 3.0);
    
    half4 color = layer.sample(position);
    half3 background = half3(bgColor);
    
    // For SwiftUI transition:
    // progress 0 = hidden (show background)
    // progress 1 = visible (show content)
    
    // Determine if we should show content or background
    float showContent;
    if (progress < 0.5) {
        // Shrinking: show content inside circle
        showContent = step(dist, s);
    } else {
        // Growing: show content outside circle  
        showContent = 1.0 - step(dist, s);
    }
    
    // Mix between background and content
    half3 result = mix(background, color.rgb, half(showContent));
    
    return half4(result, 1.0);
}
