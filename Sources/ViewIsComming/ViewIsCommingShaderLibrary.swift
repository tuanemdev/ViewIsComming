import SwiftUI

@dynamicMemberLookup
enum ViewIsCommingShaderLibrary {
    static subscript(dynamicMember name: String) -> ShaderFunction {
        ShaderLibrary.bundle(.module)[dynamicMember: name]
    }
}
