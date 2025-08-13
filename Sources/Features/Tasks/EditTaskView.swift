#if canImport(SwiftUI)
import SwiftUI

/// Form to create or edit a task.
public struct EditTaskView: View {
    @State private var title: String
    @State private var frequencyDays: Int
    @State private var lastDoneAt: Date
    @State private var notes: String

    public init(task: TaskEntity? = nil) {
        _title = State(initialValue: task?.title ?? "")
        _frequencyDays = State(initialValue: task?.frequencyDays ?? 1)
        _lastDoneAt = State(initialValue: task?.lastDoneAt ?? Date())
        _notes = State(initialValue: task?.notes ?? "")
    }

    public var body: some View {
        Form {
            Section("Details") {
                TextField("Title", text: $title)
                Stepper(value: $frequencyDays, in: 1...365) {
                    Text("Every \(frequencyDays) days")
                }
                DatePicker("Last Done", selection: $lastDoneAt, displayedComponents: .date)
                TextField("Notes", text: $notes)
            }
        }
        .navigationTitle("Task")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {}
            }
        }
    }
}
#endif
