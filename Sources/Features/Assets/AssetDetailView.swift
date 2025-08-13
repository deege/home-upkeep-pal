#if canImport(SwiftUI)
import SwiftUI

/// Detail screen for an asset with related tasks.
public struct AssetDetailView: View {
    public let asset: AssetEntity
    public init(asset: AssetEntity) { self.asset = asset }

    public var body: some View {
        List {
            Section("Details") {
                Text(asset.name)
                Text(asset.category.rawValue.capitalized)
                if let location = asset.location { Text(location) }
            }
            Section("Tasks") {
                Text("Related tasks appear here")
            }
        }
        .navigationTitle(asset.name)
    }
}
#endif
