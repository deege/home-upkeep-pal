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
    @State private var hasPurchaseDate: Bool
    @State private var purchaseDate: Date
    @State private var hasWarrantyExpiry: Bool
    @State private var warrantyExpiry: Date
    @State private var notes: String
    @State private var photosText: String

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
        _hasPurchaseDate = State(initialValue: asset?.purchaseDate != nil)
        _purchaseDate = State(initialValue: asset?.purchaseDate ?? Date())
        _hasWarrantyExpiry = State(initialValue: asset?.warrantyExpiry != nil)
        _warrantyExpiry = State(initialValue: asset?.warrantyExpiry ?? Date())
        _notes = State(initialValue: asset?.notes ?? "")
        _photosText = State(initialValue: asset?.photoFileNames.joined(separator: ", ") ?? "")
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
            Section("Additional") {
                Toggle("Purchase Date", isOn: $hasPurchaseDate)
                if hasPurchaseDate {
                    DatePicker("Purchase Date", selection: $purchaseDate, displayedComponents: .date)
                }
                Toggle("Warranty Expiry", isOn: $hasWarrantyExpiry)
                if hasWarrantyExpiry {
                    DatePicker("Warranty Expiry", selection: $warrantyExpiry, displayedComponents: .date)
                }
                TextField("Notes", text: $notes)
                TextField("Photo filenames (comma-separated)", text: $photosText)
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
                        serial: serial.isEmpty ? nil : serial,
                        purchaseDate: hasPurchaseDate ? purchaseDate : nil,
                        warrantyExpiry: hasWarrantyExpiry ? warrantyExpiry : nil,
                        notes: notes.isEmpty ? nil : notes,
                        photoFileNames: photosText.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
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
