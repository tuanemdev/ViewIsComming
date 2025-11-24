#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

bool doorway_inBounds(float2 p) {
    return p.x >= 0.0 && p.x <= 1.0 && p.y >= 0.0 && p.y <= 1.0;
}

float2 doorway_projectReflection(float2 p) {
    return p * float2(1.0, -1.2) + float2(0.0, 2.2);
}

[[ stitchable ]]
half4 doorway(float2 position,
              SwiftUI::Layer layer,
              float2 size,
              float progress,
              float depth,
              float perspective,
              float reflection,
              float isInsertion) {
    float2 uv = position / size;
    // Control when door splits open (positive = door visible)
    float doorSplitThreshold = 2.0 * abs(uv.x - 0.5) - progress;
    
    if (isInsertion > 0.5) {
        // Zoom in from center (starts small, grows to full size)
        float zoomScale = mix(depth, 1.0, progress);
        float2 zoomedUV = (uv - 0.5) * zoomScale + 0.5;
        // Hide insertion where door is visible
        if (doorSplitThreshold > 0.0) {
            return half4(0.0);
        }
        if (doorway_inBounds(zoomedUV)) {
            return layer.sample(zoomedUV * size);
        }
        // Show water reflection when zoomed image is out of bounds
        float2 reflectionUV = doorway_projectReflection(zoomedUV);
        if (doorway_inBounds(reflectionUV)) {
            half4 color = layer.sample(reflectionUV * size);
            float fadeAmount = reflection * mix(1.0, 0.0, reflectionUV.y);
            return color * half(fadeAmount);
        }
        return half4(0.0);
    }
    
    // Door splits from center to sides with perspective
    if (doorSplitThreshold > 0.0) {
        float horizontalOffset = (uv.x > 0.5 ? -1.0 : 1.0) * 0.5 * progress;
        float2 splitUV = uv + float2(horizontalOffset, 0.0);
        // Apply perspective distortion
        float perspectiveScale = 1.0 / (1.0 + perspective * progress * (1.0 - doorSplitThreshold));
        splitUV.y = (splitUV.y - 0.5) * perspectiveScale + 0.5;
        if (doorway_inBounds(splitUV)) {
            return layer.sample(splitUV * size);
        }
    }
    
    return half4(0.0);
}
