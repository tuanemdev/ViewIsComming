#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Waterfall - Waterfall flowing effect
// Custom implementation

[[ stitchable ]] half4 waterfall(float2 position,
                                 SwiftUI::Layer layer,
                                 float2 size,
                                 float progress,
                                 float speed,
                                 float amplitude) {
    // Normalize coordinates
    float2 uv = position / size;
    
    // Create waterfall effect flowing down
    float wave = sin((uv.x + progress * speed) * 10.0) * amplitude;
    
    // Offset Y based on progress and wave
    float yOffset = progress + wave * progress;
    
    // Create UV for sampling
    float2 sampleUV = uv;
    sampleUV.y -= yOffset;
    
    // Check if we're still in bounds
    bool inBounds = sampleUV.y >= 0.0 && sampleUV.y <= 1.0;
    
    // Sample the layer
    half4 color = layer.sample(position);
    
    // Calculate mask
    float mask = 0.0;
    
    if (inBounds) {
        // Gradually reveal from top
        float revealProgress = 1.0 - progress;
        mask = step(uv.y, revealProgress);
        
        // Add flowing water effect
        float flowEffect = 1.0 - abs(wave) * 0.3;
        color = color * half(flowEffect);
    }
    
    return color * half(mask);
}
