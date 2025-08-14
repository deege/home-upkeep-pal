#if canImport(SwiftUI)
import SwiftUI

/// Shows assets in a home.
public struct AssetsListView: View {
    public let home: HomeEntity
    @Binding private var assets: [AssetEntity]

    public init(home: HomeEntity, assets: Binding<[AssetEntity]>) {
        self.home = home
        _assets = assets
    }

    public var body: some View {
        List(assets) { asset in
            NavigationLink(destination: AssetDetailView(asset: asset)) {
                Text(asset.name)
            }
        }
        .overlay(assets.isEmpty ? EmptyStateView(message: "No assets yet") : nil)
    }
}
#endif
