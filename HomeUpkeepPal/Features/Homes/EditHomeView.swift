#if canImport(SwiftUI)
import SwiftUI

/// Form for creating or editing a home.
public struct EditHomeView: View {
    @State private var name: String
    @State private var address: String
    @State private var notes: String

    public init(home: HomeEntity? = nil) {
        _name = State(initialValue: home?.name ?? "")
        _address = State(initialValue: home?.address ?? "")
        _notes = State(initialValue: home?.notes ?? "")
    }

    public var body: some View {
        Form {
            Section("Details") {
                TextField("Name", text: $name)
                TextField("Address", text: $address)
                TextField("Notes", text: $notes)
            }
        }
        .navigationTitle("Home")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {}
            }
        }
    }
}
#endif
