#if canImport(SwiftUI)
import SwiftUI

/// Lists tasks for a home grouped by simple status for MVP.
public struct TasksListView: View {
    public let home: HomeEntity
    @State private var tasks: [TaskEntity] = []
    @State private var showEditTask = false

    public init(home: HomeEntity) { self.home = home }

    public var body: some View {
        List(tasks) { task in
            TaskRowView(task: task)
        }
        .navigationTitle("Tasks")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showEditTask = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationDestination(isPresented: $showEditTask) {
            EditTaskView()
        }
    }
}
#endif
