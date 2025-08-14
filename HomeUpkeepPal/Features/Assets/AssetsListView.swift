#if canImport(SwiftUI)
import SwiftUI

/// Shows assets in a home.
public struct AssetsListView: View {
    public let home: HomeEntity
    @Binding private var assets: [AssetEntity]
    private let onEdit: (AssetEntity) -> Void

    public init(home: HomeEntity, assets: Binding<[AssetEntity]>, onEdit: @escaping (AssetEntity) -> Void) {
        self.home = home
        _assets = assets
        self.onEdit = onEdit
    }

    public var body: some View {
        List(assets) { asset in
            NavigationLink(destination: AssetDetailView(home: home, asset: asset)) {
                Text(asset.name)
            }
            .swipeActions {
                Button("Edit") {
                    onEdit(asset)
                }.tint(.blue)
            }
        }
        .overlay(assets.isEmpty ? EmptyStateView(message: "No assets yet") : nil)
    }
}
#endif
