#if canImport(SwiftUI)
import SwiftUI

/// Root list showing all homes for the user.
public struct HomesListView: View {
    public init() {}
    @State private var homes: [HomeEntity] = []
    @State private var showEditHome = false

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
                    Button(action: {
                        showEditHome = true
                    }) { Image(systemName: "plus") }
                }
            }
            .navigationDestination(isPresented: $showEditHome) {
                EditHomeView { newHome in
                    homes.append(newHome)
                }
            }
            .overlay(homes.isEmpty ? EmptyStateView(message: "Create your first Home") : nil)
        }
    }
}
#endif
