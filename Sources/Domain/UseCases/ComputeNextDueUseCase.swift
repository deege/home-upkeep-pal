import Foundation

/// Computes the next due date for a task given the last completion date and frequency in days.
public struct ComputeNextDueUseCase {
    public init() {}

    /// - Parameters:
    ///   - lastDone: The most recent completion date. If nil, today is used.
    ///   - frequencyDays: Number of days between occurrences. Minimum of 1.
    /// - Returns: The computed next due date.
    public func execute(lastDone: Date?, frequencyDays: Int) -> Date {
        let base = lastDone ?? Date()
        let freq = max(frequencyDays, 1)
        return Calendar.current.date(byAdding: .day, value: freq, to: base) ?? base
    }
}
