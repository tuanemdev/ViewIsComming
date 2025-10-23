# GitHub Copilot Instructions for ViewIsComming

## Project Overview

**ViewIsComming** is a SwiftUI library that provides custom transition effects using Metal shaders. The transitions are inspired by and adapted from [GL Transitions](https://gl-transitions.com/) - a collection of GLSL shader transitions.

## Key Concept: GLSL to Metal Shader Conversion

### Source Material
- **Original Code**: GLSL shader code from [gl-transitions/gl-transitions](https://github.com/gl-transitions/gl-transitions)
- **Target Platform**: SwiftUI with Metal shaders and/or native SwiftUI modifiers
- **Implementation Flexibility**: Use any SwiftUI technique (Metal shaders, visual effects, transforms, etc.) to achieve the desired transition effect

### Critical Difference: From/To vs Single View

**GL Transitions (Web/GLSL)**:
- Works with TWO images: `getFromColor(uv)` and `getToColor(uv)`
- Uses `mix(from, to, progress)` to blend between two images
- Progress 0.0 = shows "from" image, Progress 1.0 = shows "to" image

**SwiftUI Transitions**:
- Works with ONE view: `layer.sample(position)`
- Only controls visibility/transformation of a single view
- Progress 0.0 = view hidden, Progress 1.0 = view fully visible
- Use alpha mask to control visibility: `color * mask`

### Conversion Strategy

When converting from GLSL to SwiftUI:

#### Option 1: Metal Shader Approach (Recommended for complex effects)

1. **Replace `mix()` with alpha masking**:
   ```glsl
   // GLSL (original)
   return mix(getToColor(p), getFromColor(p), step(signed, 0.5));
   ```
   
   ```metal
   // Metal (SwiftUI)
   half4 color = layer.sample(position);
   float mask = step(signed, 0.5);  // or 1.0 - step() depending on logic
   return color * half(mask);
   ```

2. **Calculate mask based on progress**:
   - Analyze the original `mix()` logic
   - Determine when the effect should show "to" color (visible)
   - Convert to mask: 1.0 = visible, 0.0 = hidden

3. **Handle edge cases**:
   - Ensure progress = 0.0 results in mask = 0.0 (fully hidden)
   - Ensure progress = 1.0 results in mask = 1.0 (fully visible)
   - Test all angles/positions, especially edge cases

#### Option 2: Native SwiftUI Approach

For simpler effects, you can use native SwiftUI modifiers:

1. **Transform-based effects**:
   - Use `.scaleEffect()`, `.rotationEffect()`, `.offset()`
   - Combine with `.opacity()` for fade transitions
   - Example: Zoom, slide, rotate effects

2. **Mask-based effects**:
   - Use `.mask()` with animated shapes or gradients
   - Combine with GeometryReader for position-based effects

3. **Blend modes and filters**:
   - Use `.blendMode()` for color mixing effects
   - Use `.blur()`, `.saturation()` for visual effects

**Choose the approach based on**:
- Complexity: Simple effects → Native SwiftUI, Complex effects → Metal shaders
- Performance: Metal shaders are more efficient for pixel-level operations
- Maintainability: Native SwiftUI is easier to understand and modify
- Cross-platform: Native SwiftUI works everywhere, Metal requires GPU support

## Implementation Pattern

For each new transition effect, follow this structure. Choose the appropriate implementation approach based on the effect's complexity.

### 1. Metal Shader File (`Sources/ViewIsComming/[EffectName]/[EffectName].metal`)

**Use this approach for**: Complex pixel-level effects, mathematical patterns, shader-based animations

```metal
#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 effectName(float2 position,
                                  SwiftUI::Layer layer,
                                  float2 size,
                                  float progress,
                                  float customParam1,
                                  float customParam2) {
    // 1. Normalize coordinates
    float2 uv = position / size;
    
    // 2. Port GLSL logic here
    // - Replace atan(y,x) with atan2(y,x)
    // - Replace mod() with fmod()
    // - Keep same math logic
    
    // 3. Calculate mask (0.0 = hidden, 1.0 = visible)
    float mask = /* your mask calculation */;
    
    // 4. Sample and apply mask
    half4 color = layer.sample(position);
    return color * half(mask);
}
```

**Key Notes**:
- Use `float2 position` (pixel coordinates) and `float2 size` (view size)
- Normalize to UV: `float2 uv = position / size`
- GLSL `mod(x, y)` → Metal `fmod(x, y)`
- GLSL `atan(y, x)` → Metal `atan2(y, x)`
- Handle negative angles from `fmod()` by normalizing to positive range

**Alternative: Native SwiftUI Implementation**

If the effect can be achieved without Metal shaders, you can skip the `.metal` file and implement the transition directly in SwiftUI using:
- `.scaleEffect()`, `.rotationEffect()`, `.offset()`, `.opacity()`
- `.mask()` with animated shapes/gradients
- `.blur()`, `.saturation()`, `.blendMode()`
- Custom `GeometryEffect` for complex transforms

### 2. SwiftUI Wrapper (`Sources/ViewIsComming/[EffectName]/[EffectName].swift`)

Implement BOTH old `AnyTransition` and new `Transition` protocol.

**For Metal shader-based transitions:**

```swift
import SwiftUI

// MARK: - AnyTransition (Legacy support for iOS 16+)
public extension AnyTransition {
    static func effectName(
        customParam1: Double = 1.0,
        customParam2: Double = 2.0
    ) -> AnyTransition {
        .modifier(
            active: EffectNameModifier(
                progress: 0,  // Hidden state
                customParam1: customParam1,
                customParam2: customParam2
            ),
            identity: EffectNameModifier(
                progress: 1,  // Visible state
                customParam1: customParam1,
                customParam2: customParam2
            )
        )
    }
}

struct EffectNameModifier: ViewModifier {
    let progress: Double
    let customParam1: Double
    let customParam2: Double
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.effectName(
                            .float2(geometryProxy.size),
                            .float(progress),
                            .float(customParam1),
                            .float(customParam2)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}

// MARK: - Transition (iOS 17+)
public extension Transition where Self == EffectNameTransition {
    static func effectName(
        customParam1: Double = 1.0,
        customParam2: Double = 2.0
    ) -> Self {
        EffectNameTransition(
            customParam1: customParam1,
            customParam2: customParam2
        )
    }
}

public struct EffectNameTransition: Transition {
    let customParam1: Double
    let customParam2: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(
                        ViewIsCommingShaderLibrary.effectName(
                            .float2(geometryProxy.size),
                            .float(phase.isIdentity ? 1 : 0),
                            .float(customParam1),
                            .float(customParam2)
                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
```

**Key Points**:
- `active` state: `progress: 0` (hidden/removed)
- `identity` state: `progress: 1` (visible/inserted)
- `TransitionPhase.isIdentity` = true means visible state
- Always pass `geometryProxy.size` as first parameter
- Use `.float()`, `.float2()` for shader parameters

**For native SwiftUI-based transitions:**

```swift
import SwiftUI

// MARK: - AnyTransition
public extension AnyTransition {
    static func effectName(
        customParam1: Double = 1.0
    ) -> AnyTransition {
        .modifier(
            active: EffectNameModifier(progress: 0, customParam1: customParam1),
            identity: EffectNameModifier(progress: 1, customParam1: customParam1)
        )
    }
}

struct EffectNameModifier: ViewModifier {
    let progress: Double
    let customParam1: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(progress)  // Example: scale from 0 to 1
            .opacity(progress)      // Example: fade in
            // Add more modifiers as needed
    }
}

// MARK: - Transition
public extension Transition where Self == EffectNameTransition {
    static func effectName(customParam1: Double = 1.0) -> Self {
        EffectNameTransition(customParam1: customParam1)
    }
}

public struct EffectNameTransition: Transition {
    let customParam1: Double
    
    public func body(content: Content, phase: TransitionPhase) -> some View {
        let progress = phase.isIdentity ? 1.0 : 0.0
        
        content
            .scaleEffect(progress)
            .opacity(progress)
            // Add more modifiers as needed
    }
}
```

### 3. Demo View (`Example/Example/Demo/[EffectName]View.swift`)

**Important**: Demo views should allow real-time parameter adjustment using sliders and toggles, not multiple animation trigger buttons.

```swift
import SwiftUI
import ViewIsComming

struct EffectNameView: View {
    @State private var showView = true
    // Controls - add @State variables for each customizable parameter
    @State private var customParam1: Double = 1.0
    @State private var customParam2: Double = 2.0
    @State private var boolParam: Bool = true
    
    var body: some View {
        ScrollView {
            ZStack {
                if showView {
                    Image(.haNoi)
                        .resizable()
                        .transition(
                            .effectName(
                                customParam1: customParam1,
                                customParam2: customParam2,
                                boolParam: boolParam
                            )
                        )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            // Controls - Use sliders, toggles, and preset buttons
            VStack(alignment: .leading, spacing: 15) {
                // Slider for numeric parameters
                VStack(alignment: .leading) {
                    Text("Custom Param 1: \(customParam1, specifier: "%.1f")")
                        .font(.caption)
                    Slider(value: $customParam1, in: 0.1...5.0)
                }
                
                VStack(alignment: .leading) {
                    Text("Custom Param 2: \(Int(customParam2))")
                        .font(.caption)
                    Slider(value: $customParam2, in: 1...20, step: 1)
                }
                
                // Toggle for boolean parameters
                Toggle("Bool Param", isOn: $boolParam)
                    .font(.caption)
                
                // Preset buttons (optional) - only SET values, don't trigger animation
                HStack(spacing: 10) {
                    Button("Preset 1") {
                        customParam1 = 1.0
                        customParam2 = 5.0
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Preset 2") {
                        customParam1 = 3.0
                        customParam2 = 15.0
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Single Trigger Button - only this button triggers the animation
            Button(action: {
                withAnimation(.easeInOut(duration: 1.5)) {
                    showView.toggle()
                }
            }) {
                Text("Toggle Transition")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("EffectName")
    }
}

#Preview {
    EffectNameView()
}
```

**Demo View Guidelines**:
- Use `@State` variables for all customizable parameters
- Pass state variables to the transition in real-time
- Use `Slider` for numeric parameters (Double/CGFloat/Int)
- Use `Toggle` for boolean parameters
- Use `Picker` for enum parameters
- Preset buttons should only SET parameter values, not trigger animations
- Have only ONE "Toggle Transition" button that triggers the animation
- Group controls in a VStack with gray background
- Show current parameter values in labels above sliders
- Use appropriate number formatting: `%.1f` for floats, `%d` or `Int()` for integers
```

### 4. Register in Shader Library (`Sources/ViewIsComming/ViewIsCommingShaderLibrary.swift`)

```swift
import SwiftUI

@dynamicMemberLookup
enum ViewIsCommingShaderLibrary {
    static subscript(dynamicMember name: String) -> ShaderFunction {
        ShaderLibrary.bundle(.module)[dynamicMember: name]
    }
}
```

## Testing Checklist

When implementing a new transition:

- [ ] Progress 0.0 → view completely hidden
- [ ] Progress 1.0 → view fully visible (no alpha/mask issues)
- [ ] Smooth animation throughout 0.0 to 1.0 range
- [ ] Test all edge cases (corners, angles, boundaries)
- [ ] Works with different view sizes
- [ ] Works with both `.easeIn` and `.easeOut` animations
- [ ] No visual glitches at transition start/end
- [ ] Both `AnyTransition` and `Transition` implementations work

## Common Pitfalls & Solutions

### Problem: View disappears at progress = 1.0
**Cause**: Mask logic inverted
**Solution**: Check `sign()` and `step()` logic, may need `1.0 - mask`

### Problem: Missing quadrant/section during animation
**Cause**: Negative angle handling in `fmod()`
**Solution**: Normalize negative results to positive range:
```metal
if (modPos < 0.0) {
    modPos += period;
}
```

### Problem: Harsh edges/no smoothness
**Cause**: Using `step()` without smoothing
**Solution**: Replace `step()` with `smoothstep()` where appropriate

## Resources

- **Official SwiftUI Transition Docs**: https://developer.apple.com/documentation/swiftui/transition
- **GL Transitions Source**: https://github.com/gl-transitions/gl-transitions
- **GL Transitions Gallery**: https://gl-transitions.com/
- **Metal Shading Language Spec**: https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

## File Structure

```
Sources/ViewIsComming/
├── ViewIsCommingShaderLibrary.swift
├── NoneTransition.swift
├── [EffectName]/
│   ├── [EffectName].metal
│   └── [EffectName].swift
Example/Example/Demo/
└── [EffectName]View.swift
```

## Code Style Guidelines

- Use descriptive parameter names matching original GLSL
- Add comments explaining GLSL → Metal conversions
- Document edge cases and fixes
- Keep shader code readable with proper spacing
- Use `half4` for color output (memory efficient)
- Use `float` for calculations (precision)
