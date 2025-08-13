#if canImport(SwiftUI)
import SwiftUI

/// Simple reusable empty state view with a message and optional action button.
public struct EmptyStateView: View {
    let message: String
    let actionTitle: String?
    let action: (() -> Void)?

    public init(message: String, actionTitle: String? = nil, action: (() -> Void)? = nil) {
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        VStack(spacing: 16) {
            Text(message).multilineTextAlignment(.center).foregroundColor(.secondary)
            if let actionTitle = actionTitle {
                Button(actionTitle) { action?() }
            }
        }
        .padding()
    }
}
#endif
