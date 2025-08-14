#if canImport(SwiftUI)
import SwiftUI

/// Small badge view for statuses like "Shared".
public struct BadgeView: View {
    let text: String
    public init(_ text: String) { self.text = text }

    public var body: some View {
        Text(text)
            .font(.caption2)
            .padding(4)
            .background(Capsule().fill(Color.accentColor.opacity(0.2)))
    }
}
#endif
