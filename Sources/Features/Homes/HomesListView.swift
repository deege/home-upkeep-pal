#if canImport(SwiftUI)
import SwiftUI

/// Root list showing all homes for the user.
public struct HomesListView: View {
    public init() {}
    @State private var homes: [HomeEntity] = []

    public var body: some View {
        NavigationStack {
            List(homes) { home in
                NavigationLink(destination: HomeDashboardView(home: home)) {
                    Text(home.name)
                }
            }
            .navigationTitle("Homes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) { Image(systemName: "plus") }
                }
            }
            .overlay(homes.isEmpty ? EmptyStateView(message: "Create your first Home") : nil)
        }
    }
}
#endif
