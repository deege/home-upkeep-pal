#if canImport(SwiftUI) && canImport(UIKit)
import SwiftUI
import CloudKit
import UIKit

/// Wrapper to present `UICloudSharingController` in SwiftUI.
public struct CloudSharingController: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UICloudSharingController
    let share: CKShare
    let container: CKContainer

    public init(share: CKShare, container: CKContainer) {
        self.share = share
        self.container = container
    }

    public func makeUIViewController(context: Context) -> UICloudSharingController {
        let controller = UICloudSharingController(share: share, container: container)
        return controller
    }

    public func updateUIViewController(_ uiViewController: UICloudSharingController, context: Context) {}
}
#endif
