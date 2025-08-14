#if canImport(SwiftUI)
import SwiftUI

/// Row representing a task with relative due date and optional asset chip.
public struct TaskRowView: View {
    public let task: TaskEntity

    public init(task: TaskEntity) { self.task = task }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
            if task.isArchived, let done = task.lastDoneAt {
                Text("Completed \(done, style: .date)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                Text(task.nextDueAt, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
#endif
