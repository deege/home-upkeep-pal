#if canImport(SwiftUI)
import SwiftUI

/// Form to create or edit a task.
public struct EditTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var frequencyDays: Int
    @State private var lastDoneAt: Date
    @State private var notes: String
    @State private var selectedAssetID: UUID?
    @State private var isArchived: Bool
    @State private var assets: [AssetEntity] = []

    private let home: HomeEntity
    private let asset: AssetEntity?
    private let assetRepository = CoreDataAssetRepository()
    private let onSave: (TaskEntity) -> Void
    private let existingTask: TaskEntity?

    public init(home: HomeEntity,
                asset: AssetEntity? = nil,
                task: TaskEntity? = nil,
                onSave: @escaping (TaskEntity) -> Void = { _ in }) {
        self.home = home
        self.asset = asset
        self.onSave = onSave
        self.existingTask = task
        _title = State(initialValue: task?.title ?? "")
        _frequencyDays = State(initialValue: task?.frequencyDays ?? 1)
        _lastDoneAt = State(initialValue: task?.lastDoneAt ?? Date())
        _notes = State(initialValue: task?.notes ?? "")
        _selectedAssetID = State(initialValue: task?.assetID ?? asset?.id)
        _isArchived = State(initialValue: task?.isArchived ?? false)
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
            Section("Asset") {
                Picker("Asset", selection: $selectedAssetID) {
                    Text("None").tag(UUID?.none)
                    ForEach(assets) { asset in
                        Text(asset.name).tag(Optional(asset.id))
                    }
                }
            }
            Section("Status") {
                Toggle("Archived", isOn: $isArchived)
            }
        }
        .navigationTitle("Task")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let nextDue = ComputeNextDueUseCase().execute(lastDone: lastDoneAt, frequencyDays: frequencyDays)
                    let task = TaskEntity(
                        id: existingTask?.id ?? UUID(),
                        homeID: home.id,
                        assetID: selectedAssetID,
                        title: title,
                        notes: notes.isEmpty ? nil : notes,
                        frequencyDays: frequencyDays,
                        lastDoneAt: lastDoneAt,
                        nextDueAt: nextDue,
                        isArchived: isArchived,
                        createdAt: existingTask?.createdAt ?? Date(),
                        updatedAt: Date()
                    )
                    onSave(task)
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
        }
        .task {
            assets = (try? await assetRepository.fetchAssets(homeID: home.id)) ?? []
        }
    }
}
#endif
