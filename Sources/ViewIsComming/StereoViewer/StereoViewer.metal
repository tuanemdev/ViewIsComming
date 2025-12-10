#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

constant float2 stereoViewer_cornerBottomLeft = float2(0.0, 0.0);
constant float2 stereoViewer_cornerTopLeft = float2(0.0, 1.0);
constant float2 stereoViewer_cornerTopRight = float2(1.0, 1.0);
constant float2 stereoViewer_cornerBottomRight = float2(1.0, 0.0);

bool stereoViewer_inCorner(float2 point, float2 corner, float2 radius) {
    float2 axis = (stereoViewer_cornerTopRight - corner) - corner;
    point = point - (corner + axis * radius);
    point *= axis / radius;
    return (point.x > 0.0 && point.y > -1.0) || (point.y > 0.0 && point.x > -1.0) || dot(point, point) < 1.0;
}

bool stereoViewer_isInsideRoundedRect(float2 point, float2 cornerSize) {
    return stereoViewer_inCorner(point, stereoViewer_cornerBottomLeft, cornerSize) &&
    stereoViewer_inCorner(point, stereoViewer_cornerTopLeft, cornerSize) &&
    stereoViewer_inCorner(point, stereoViewer_cornerBottomRight, cornerSize) &&
    stereoViewer_inCorner(point, stereoViewer_cornerTopRight, cornerSize);
}

// Screen blend mode - combines two colors like overlapping light
half4 stereoViewer_screenBlend(half4 colorA, half4 colorB) {
    return 1.0h - (1.0h - colorA) * (1.0h - colorB);
}

// Inverse of screen blend - prepares color for screen blending
half4 stereoViewer_unscreen(half4 color) {
    return 1.0h - sqrt(1.0h - color);
}

// Create 2D rotation matrix
float3x3 stereoViewer_rotationMatrix(float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return float3x3(float3(c, s, 0.0), float3(-s, c, 0.0), float3(0.0, 0.0, 1.0));
}

// Create 2D translation matrix
float3x3 stereoViewer_translationMatrix(float x, float y) {
    return float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(-x, -y, 1.0));
}

// Create 2D scale matrix
float3x3 stereoViewer_scaleMatrix(float x, float y) {
    return float3x3(float3(x, 0.0, 0.0), float3(0.0, y, 0.0), float3(0.0, 0.0, 1.0));
}

[[ stitchable ]]
half4 stereoViewer(float2 position,
                   SwiftUI::Layer layer,
                   float2 size,
                   float progress,
                   float zoom,
                   float cornerRadius) {
    float2 uv = position / size;
    float aspectRatio = size.x / size.y;
    float2 cornerSize = float2(cornerRadius / aspectRatio, cornerRadius);
    
    // Timeline (50-50 split):
    // 0.00 - 0.50: Two masks rotate in from sides, merging to reveal image
    // 0.50 - 1.00: Zoom out + corners disappear
    // 1.00: Full image
    
    half4 transparent = half4(0.0);
    half4 black = half4(0.0, 0.0, 0.0, 1.0);
    
    if (progress <= 0.0) {
        return transparent;
    }
    if (progress >= 1.0) {
        return layer.sample(position);
    }
    
    if (progress < 0.5) {
        // Phase 1: Two masks rotate in from sides (50%)
        float phaseProgress = progress / 0.5; // 0 -> 1
        // Rotation angle: starts large (masks apart) -> 0 (masks merged)
        float rotationAngle = 1.0 - phaseProgress;
        rotationAngle = rotationAngle * rotationAngle; // Easing
        rotationAngle /= 2.4;
        float3 point3D = float3(uv, 1.0);
        // Build transformation matrices for left and right masks
        float3x3 centerAndScale = stereoViewer_translationMatrix(-0.5, -0.5) * stereoViewer_scaleMatrix(1.0, aspectRatio);
        float3x3 unscaleAndUncenter = stereoViewer_scaleMatrix(1.0 / zoom, 1.0 / (zoom * aspectRatio)) * stereoViewer_translationMatrix(0.5, 0.5);
        float3x3 slideLeft = stereoViewer_translationMatrix(-2.0, 0.0);
        float3x3 slideRight = stereoViewer_translationMatrix(2.0, 0.0);
        float3x3 rotation = stereoViewer_rotationMatrix(rotationAngle);
        // Left mask: slides right, rotates, slides left
        float3x3 leftMaskTransform = centerAndScale * slideRight * rotation * slideLeft * unscaleAndUncenter;
        // Right mask: slides left, rotates, slides right
        float3x3 rightMaskTransform = centerAndScale * slideLeft * rotation * slideRight * unscaleAndUncenter;
        
        float2 leftMaskPoint = (leftMaskTransform * point3D).xy;
        float2 rightMaskPoint = (rightMaskTransform * point3D).xy;
        
        bool inLeftMask = stereoViewer_isInsideRoundedRect(leftMaskPoint, cornerSize);
        bool inRightMask = stereoViewer_isInsideRoundedRect(rightMaskPoint, cornerSize);
        if (inLeftMask || inRightMask) {
            float2 sampleUV = (uv - 0.5) / zoom + 0.5;
            if (!stereoViewer_isInsideRoundedRect(sampleUV, cornerSize)) {
                return transparent;
            }
            half4 imageColor = stereoViewer_unscreen(layer.sample(sampleUV * size));
            return stereoViewer_screenBlend(inLeftMask ? imageColor : black, inRightMask ? imageColor : black);
        }
        return transparent;
    }
    
    // Phase 2: Zoom out + corners disappear (50%)
    float phaseProgress = (progress - 0.5) / 0.5; // 0 -> 1
    // Zoom transitions from zoom level to 1.0 (no zoom)
    float currentZoom = zoom + (1.0 - zoom) * phaseProgress;
    float2 sampleUV = (uv - 0.5) / currentZoom + 0.5;
    // Corner size shrinks from full to 0
    float2 currentCornerSize = cornerSize * (1.0 - phaseProgress);
    // When corners are essentially gone, sample directly
    if (currentCornerSize.x < 0.001 || currentCornerSize.y < 0.001) {
        return layer.sample(sampleUV * size);
    }
    if (stereoViewer_isInsideRoundedRect(sampleUV, currentCornerSize)) {
        return layer.sample(sampleUV * size);
    }
    return transparent;
}
