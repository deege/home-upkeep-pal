import Foundation

/// Domain model representing a Home Asset like an appliance or paint color.
public struct AssetEntity: Identifiable, Codable, Equatable {
    public enum Category: String, Codable, CaseIterable {
        case appliance
        case paint
        case safety
        case hvac
        case plumbing
        case other
    }

    public var id: UUID
    public var homeID: UUID
    public var name: String
    public var category: Category
    public var location: String?
    public var model: String?
    public var serial: String?
    public var purchaseDate: Date?
    public var warrantyExpiry: Date?
    public var notes: String?
    public var photoFileNames: [String]
    public var createdAt: Date
    public var updatedAt: Date

    public init(id: UUID = UUID(),
                homeID: UUID,
                name: String,
                category: Category = .other,
                location: String? = nil,
                model: String? = nil,
                serial: String? = nil,
                purchaseDate: Date? = nil,
                warrantyExpiry: Date? = nil,
                notes: String? = nil,
                photoFileNames: [String] = [],
                createdAt: Date = Date(),
                updatedAt: Date = Date()) {
        self.id = id
        self.homeID = homeID
        self.name = name
        self.category = category
        self.location = location
        self.model = model
        self.serial = serial
        self.purchaseDate = purchaseDate
        self.warrantyExpiry = warrantyExpiry
        self.notes = notes
        self.photoFileNames = Array(photoFileNames.prefix(3))
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
