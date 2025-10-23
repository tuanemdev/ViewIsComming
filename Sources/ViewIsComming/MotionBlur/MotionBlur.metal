#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// MotionBlur - Motion blur transition
// Custom implementation with directional blur

[[ stitchable ]] half4 motionBlur(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float angle,
                                  float samplesFloat) {
    // Cast float to int for samples
    int samples = int(samplesFloat);
    
    // Convert angle to radians
    float angleRad = angle * 3.14159265359 / 180.0;
    
    // Calculate blur direction
    float2 direction = float2(cos(angleRad), sin(angleRad));
    
    // Blur amount based on progress
    float blurAmount = (1.0 - abs(progress - 0.5) * 2.0) * 0.05;
    
    // Accumulate samples
    half4 color = half4(0.0);
    float totalWeight = 0.0;
    
    for (int i = 0; i < samples; i++) {
        float offset = (float(i) / float(samples - 1) - 0.5) * 2.0;
        float2 samplePos = position + direction * offset * blurAmount * size;
        float weight = 1.0 - abs(offset);
        
        color += layer.sample(samplePos) * half(weight);
        totalWeight += weight;
    }
    
    color /= half(totalWeight);
    
    // Apply fade based on progress
    float mask = progress;
    
    return color * half(mask);
}
