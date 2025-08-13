#if canImport(SwiftUI)
import SwiftUI

/// Lists tasks for a home grouped by simple status for MVP.
public struct TasksListView: View {
    public let home: HomeEntity
    @State private var tasks: [TaskEntity] = []
    @State private var isPresentingNewTask = false

    public init(home: HomeEntity) { self.home = home }

    public var body: some View {
        List(tasks) { task in
            TaskRowView(task: task)
        }
        .navigationTitle("Tasks")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresentingNewTask = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewTask) {
            NavigationStack {
                EditTaskView()
            }
        }
    }
}
#endif
