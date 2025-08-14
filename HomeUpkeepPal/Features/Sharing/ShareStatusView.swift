#if canImport(SwiftUI)
import SwiftUI

/// Displays sharing information for a home.
public struct ShareStatusView: View {
    public let home: HomeEntity
    @State private var participants: [String] = [] // Placeholder for CKShare.Participant

    public init(home: HomeEntity) { self.home = home }

    public var body: some View {
        List {
            Section("Participants") {
                ForEach(participants, id: \.self) { name in
                    Text(name)
                }
            }
            Button("Manage Sharing") {
                // TODO: Present CloudSharingController
            }
        }
        .navigationTitle("Sharing")
    }
}
#endif
