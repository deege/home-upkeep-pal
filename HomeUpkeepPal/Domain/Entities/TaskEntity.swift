import Foundation

/// Domain model representing a maintenance task for a Home or Asset.
public struct TaskEntity: Identifiable, Codable, Equatable {
    public var id: UUID
    public var homeID: UUID
    public var assetID: UUID?
    public var title: String
    public var notes: String?
    public var frequencyDays: Int
    public var lastDoneAt: Date?
    public var nextDueAt: Date
    public var isArchived: Bool
    public var createdAt: Date
    public var updatedAt: Date

    public init(id: UUID = UUID(),
                homeID: UUID,
                assetID: UUID? = nil,
                title: String,
                notes: String? = nil,
                frequencyDays: Int,
                lastDoneAt: Date? = nil,
                nextDueAt: Date,
                isArchived: Bool = false,
                createdAt: Date = Date(),
                updatedAt: Date = Date()) {
        self.id = id
        self.homeID = homeID
        self.assetID = assetID
        self.title = title
        self.notes = notes
        self.frequencyDays = frequencyDays
        self.lastDoneAt = lastDoneAt
        self.nextDueAt = nextDueAt
        self.isArchived = isArchived
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
