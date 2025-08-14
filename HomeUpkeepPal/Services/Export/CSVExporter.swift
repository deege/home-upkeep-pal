import Foundation

/// Utility to export domain entities as CSV strings. In the real app this would write to files and present a share sheet.
public struct CSVExporter {
    public init() {}

    public func exportTasks(home: HomeEntity, tasks: [TaskEntity], assets: [AssetEntity]) -> String {
        let header = "HomeName,TaskTitle,AssetName,FrequencyDays,LastDoneAt,NextDueAt,Notes"
        let rows = tasks.map { task -> String in
            let assetName = assets.first(where: { $0.id == task.assetID })?.name ?? ""
            let last = task.lastDoneAt.map { isoFormatter.string(from: $0) } ?? ""
            let next = isoFormatter.string(from: task.nextDueAt)
            let notes = task.notes?.replacingOccurrences(of: ",", with: " ") ?? ""
            return "\(home.name),\(task.title),\(assetName),\(task.frequencyDays),\(last),\(next),\(notes)"
        }
        return ([header] + rows).joined(separator: "\n")
    }

    public func exportAssets(home: HomeEntity, assets: [AssetEntity]) -> String {
        let header = "HomeName,AssetName,Category,Location,Model,Serial,PurchaseDate,WarrantyExpiry,Notes"
        let rows = assets.map { asset -> String in
            let purchase = asset.purchaseDate.map { isoFormatter.string(from: $0) } ?? ""
            let warranty = asset.warrantyExpiry.map { isoFormatter.string(from: $0) } ?? ""
            let notes = asset.notes?.replacingOccurrences(of: ",", with: " ") ?? ""
            return "\(home.name),\(asset.name),\(asset.category.rawValue),\(asset.location ?? ""),\(asset.model ?? ""),\(asset.serial ?? ""),\(purchase),\(warranty),\(notes)"
        }
        return ([header] + rows).joined(separator: "\n")
    }

    // MARK: - Helpers
    private var isoFormatter: ISO8601DateFormatter { ISO8601DateFormatter() }
}
