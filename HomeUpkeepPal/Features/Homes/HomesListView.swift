#if canImport(SwiftUI)
import SwiftUI

/// Root list showing all homes for the user.
public struct HomesListView: View {
    private let homeRepository = CoreDataHomeRepository()
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
                    Task {
                        try? await homeRepository.add(home: newHome)
                        homes = (try? await homeRepository.fetchHomes()) ?? homes
                    }
                }
            }
            .overlay(homes.isEmpty ? EmptyStateView(message: "Create your first Home") : nil)
        }
        .task {
            homes = (try? await homeRepository.fetchHomes()) ?? []
        }
    }
}
#endif
