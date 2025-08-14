#if canImport(SwiftUI)
import SwiftUI

/// Shows assets in a home.
public struct AssetsListView: View {
    public let home: HomeEntity
    @Binding private var assets: [AssetEntity]
    @State private var showEdit = false
    @State private var editingAsset: AssetEntity? = nil
    private let assetRepository = CoreDataAssetRepository()

    public init(home: HomeEntity, assets: Binding<[AssetEntity]>) {
        self.home = home
        _assets = assets
    }

    public var body: some View {
        Group {
            List(assets) { asset in
                NavigationLink(destination: AssetDetailView(home: home, asset: asset)) {
                    Text(asset.name)
                }
                .swipeActions {
                    Button("Edit") {
                        editingAsset = asset
                        showEdit = true
                    }.tint(.blue)
                }
            }
            .overlay(assets.isEmpty ? EmptyStateView(message: "No assets yet") : nil)
        }
        .navigationDestination(isPresented: $showEdit) {
            EditAssetView(home: home, asset: editingAsset) { newAsset in
                Task {
                    if let _ = editingAsset {
                        try? await assetRepository.update(asset: newAsset)
                        if let idx = assets.firstIndex(where: { $0.id == newAsset.id }) {
                            assets[idx] = newAsset
                        }
                    }
                }
            }
        }
    }
}
#endif
