import Foundation

/// Domain model representing a Home. This struct is persistence agnostic so it can be reused on other platforms.
public struct HomeEntity: Identifiable, Codable, Equatable {
    public var id: UUID
    public var name: String
    public var address: String?
    public var notes: String?
    public var createdAt: Date
    public var updatedAt: Date

    public init(id: UUID = UUID(),
                name: String,
                address: String? = nil,
                notes: String? = nil,
                createdAt: Date = Date(),
                updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.address = address
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
