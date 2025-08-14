#if canImport(SwiftUI)
import SwiftUI

/// Form to create or edit a task.
public struct EditTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var frequencyDays: Int
    @State private var lastDoneAt: Date
    @State private var notes: String

    private let home: HomeEntity
    private let asset: AssetEntity?
    private let onSave: (TaskEntity) -> Void

    public init(home: HomeEntity,
                asset: AssetEntity? = nil,
                task: TaskEntity? = nil,
                onSave: @escaping (TaskEntity) -> Void = { _ in }) {
        self.home = home
        self.asset = asset
        self.onSave = onSave
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
                Button("Save") {
                    let nextDue = Calendar.current.date(byAdding: .day, value: frequencyDays, to: lastDoneAt) ?? Date()
                    let task = TaskEntity(
                        homeID: home.id,
                        assetID: asset?.id,
                        title: title,
                        notes: notes.isEmpty ? nil : notes,
                        frequencyDays: frequencyDays,
                        lastDoneAt: lastDoneAt,
                        nextDueAt: nextDue
                    )
                    onSave(task)
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
        }
    }
}
#endif
