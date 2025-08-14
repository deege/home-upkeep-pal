#if canImport(SwiftUI)
import SwiftUI

/// Lists tasks for a home grouped by simple status for MVP.
public struct TasksListView: View {
    public let home: HomeEntity
    @Binding private var tasks: [TaskEntity]

    public init(home: HomeEntity, tasks: Binding<[TaskEntity]>) {
        self.home = home
        _tasks = tasks
    }

    public var body: some View {
        List(tasks) { task in
            TaskRowView(task: task)
        }
        .overlay(tasks.isEmpty ? EmptyStateView(message: "No tasks yet") : nil)
    }
}
#endif
