import Foundation

/// Marks a task as completed now and recomputes its next due date.
public struct MarkTaskDoneUseCase {
    private let computeNextDue: ComputeNextDueUseCase

    public init(computeNextDue: ComputeNextDueUseCase = .init()) {
        self.computeNextDue = computeNextDue
    }

    public mutating func execute(task: inout TaskEntity, at date: Date = Date()) {
        task.lastDoneAt = date
        task.nextDueAt = computeNextDue.execute(lastDone: date, frequencyDays: task.frequencyDays)
        task.updatedAt = date
    }
}
