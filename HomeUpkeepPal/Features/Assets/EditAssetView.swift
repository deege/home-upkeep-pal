#if canImport(SwiftUI)
import SwiftUI

/// Form to create or edit an asset.
public struct EditAssetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var category: AssetEntity.Category
    @State private var location: String
    @State private var model: String
    @State private var serial: String

    private let home: HomeEntity
    private let onSave: (AssetEntity) -> Void

    public init(home: HomeEntity,
                asset: AssetEntity? = nil,
                onSave: @escaping (AssetEntity) -> Void = { _ in }) {
        self.home = home
        self.onSave = onSave
        _name = State(initialValue: asset?.name ?? "")
        _category = State(initialValue: asset?.category ?? .other)
        _location = State(initialValue: asset?.location ?? "")
        _model = State(initialValue: asset?.model ?? "")
        _serial = State(initialValue: asset?.serial ?? "")
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
                TextField("Model", text: $model)
                TextField("Serial Number", text: $serial)
            }
        }
        .navigationTitle("Asset")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let asset = AssetEntity(
                        homeID: home.id,
                        name: name,
                        category: category,
                        location: location.isEmpty ? nil : location,
                        model: model.isEmpty ? nil : model,
                        serial: serial.isEmpty ? nil : serial
                    )
                    onSave(asset)
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
        }
    }
}
#endif
