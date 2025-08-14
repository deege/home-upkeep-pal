#if canImport(SwiftUI)
import SwiftUI

/// Lists tasks for a home grouped by simple status for MVP.
public struct TasksListView: View {
    public let home: HomeEntity
    @Binding private var tasks: [TaskEntity]
    @State private var showCompleted = false
    private let taskRepository = CoreDataTaskRepository()
    private var computeNextDue = ComputeNextDueUseCase()

    public init(home: HomeEntity, tasks: Binding<[TaskEntity]>) {
        self.home = home
        _tasks = tasks
    }

    private var filteredTasks: [TaskEntity] {
        tasks.filter { showCompleted ? $0.isArchived : !$0.isArchived }
    }

    public var body: some View {
        List {
            ForEach(filteredTasks) { task in
                HStack {
                    Button(action: { toggle(task) }) {
                        Image(systemName: task.isArchived ? "checkmark.circle" : "circle")
                    }
                    NavigationLink(destination: EditTaskView(home: home, task: task) { updated in
                        Task {
                            try? await taskRepository.update(task: updated)
                            if let idx = tasks.firstIndex(where: { $0.id == updated.id }) {
                                tasks[idx] = updated
                            }
                        }
                    }) {
                        TaskRowView(task: task)
                    }
                }
            }
        }
        .overlay(filteredTasks.isEmpty ? EmptyStateView(message: showCompleted ? "No completed tasks" : "No tasks yet") : nil)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(showCompleted ? "Hide Completed" : "Show Completed") { showCompleted.toggle() }
            }
        }
    }

    private func toggle(_ task: TaskEntity) {
        Task {
            guard let idx = tasks.firstIndex(where: { $0.id == task.id }) else { return }
            var updated = task
            if task.isArchived {
                updated.isArchived = false
                updated.lastDoneAt = nil
                updated.updatedAt = Date()
                try? await taskRepository.update(task: updated)
                tasks[idx] = updated
            } else {
                let now = Date()
                updated.isArchived = true
                updated.lastDoneAt = now
                updated.updatedAt = now
                try? await taskRepository.update(task: updated)
                tasks[idx] = updated

                let nextDue = computeNextDue.execute(lastDone: now, frequencyDays: task.frequencyDays)
                let newTask = TaskEntity(homeID: task.homeID,
                                         assetID: task.assetID,
                                         title: task.title,
                                         notes: task.notes,
                                         frequencyDays: task.frequencyDays,
                                         lastDoneAt: nil,
                                         nextDueAt: nextDue)
                try? await taskRepository.add(task: newTask)
                tasks.append(newTask)
            }
        }
    }
}
#endif
