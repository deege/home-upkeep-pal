#if canImport(SwiftUI)
import SwiftUI

/// App settings screen.
public struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var summaryTime = DateComponents(hour: 9)

    public init() {}

    public var body: some View {
        Form {
            Section("Notifications") {
                Toggle("Daily Summary", isOn: $notificationsEnabled)
                DatePicker("Time", selection: Binding(get: {
                    Calendar.current.date(from: summaryTime) ?? Date()
                }, set: { date in
                    summaryTime = Calendar.current.dateComponents([.hour, .minute], from: date)
                }), displayedComponents: .hourAndMinute)
            }
            Section("About") {
                Link("Support", destination: URL(string: "mailto:support@example.com")!)
            }
        }
        .navigationTitle("Settings")
    }
}
#endif
