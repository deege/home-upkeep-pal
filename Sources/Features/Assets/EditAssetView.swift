#if canImport(SwiftUI)
import SwiftUI

/// Form to create or edit an asset.
public struct EditAssetView: View {
    @State private var name: String
    @State private var category: AssetEntity.Category
    @State private var location: String

    public init(asset: AssetEntity? = nil) {
        _name = State(initialValue: asset?.name ?? "")
        _category = State(initialValue: asset?.category ?? .other)
        _location = State(initialValue: asset?.location ?? "")
    }

    public var body: some View {
        Form {
            Section("Details") {
                TextField("Name", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(AssetEntity.Category.allCases, id: \.self) { c in
                        Text(c.rawValue.capitalized).tag(c)
                    }
                }
                TextField("Location", text: $location)
            }
        }
        .navigationTitle("Asset")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {}
            }
        }
    }
}
#endif
