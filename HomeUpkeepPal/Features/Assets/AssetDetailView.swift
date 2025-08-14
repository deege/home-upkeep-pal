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
                if let model = asset.model { Text(model) }
                if let serial = asset.serial { Text(serial) }
                if let purchase = asset.purchaseDate {
                    Text("Purchased on \(purchase.formatted(date: .abbreviated, time: .omitted))")
                }
                if let warranty = asset.warrantyExpiry {
                    Text("Warranty expires \(warranty.formatted(date: .abbreviated, time: .omitted))")
                }
            }
            if let notes = asset.notes {
                Section("Notes") { Text(notes) }
            }
            if !asset.photoFileNames.isEmpty {
                Section("Photos") {
                    ForEach(asset.photoFileNames, id: \.self) { name in
                        Text(name)
                    }
                }
            }
            Section("Tasks") {
                Text("Related tasks appear here")
            }
        }
        .navigationTitle(asset.name)
    }
}
#endif
