import Foundation

/// Pushes the next due date of a task by a number of days without changing last completion date.
public struct SnoozeTaskUseCase {
    public init() {}

    public mutating func execute(task: inout TaskEntity, days: Int) {
        guard days > 0 else { return }
        if let newDate = Calendar.current.date(byAdding: .day, value: days, to: task.nextDueAt) {
            task.nextDueAt = newDate
            task.updatedAt = Date()
        }
    }
}
