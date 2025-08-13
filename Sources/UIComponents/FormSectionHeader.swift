#if canImport(SwiftUI)
import SwiftUI

/// Simple header view to style grouped form sections consistently.
public struct FormSectionHeader: View {
    let text: String
    public init(_ text: String) { self.text = text }

    public var body: some View {
        Text(text).font(.headline).textCase(.none)
    }
}
#endif
