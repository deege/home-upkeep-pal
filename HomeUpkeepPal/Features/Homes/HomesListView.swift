#if canImport(SwiftUI)
import SwiftUI

/// Root list showing all homes for the user.
public struct HomesListView: View {
    private let homeRepository = CoreDataHomeRepository()
    public init() {}
    @State private var homes: [HomeEntity] = []
    @State private var showEditHome = false
    @State private var editingHome: HomeEntity? = nil

    public var body: some View {
        NavigationStack {
            List(homes) { home in
                NavigationLink(destination: HomeDashboardView(home: home)) {
                    Text(home.name)
                }
                .swipeActions {
                    Button("Edit") {
                        editingHome = home
                        showEditHome = true
                    }.tint(.blue)
                }
            }
            .overlay(homes.isEmpty ? EmptyStateView(message: "Create your first Home") : nil)
        }
        .navigationTitle("Homes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    editingHome = nil
                    showEditHome = true
                }) { Image(systemName: "plus") }
            }
        }
        .navigationDestination(isPresented: $showEditHome) {
            EditHomeView(home: editingHome) { newHome in
                Task {
                    if editingHome != nil {
                        try? await homeRepository.update(home: newHome)
                    } else {
                        try? await homeRepository.add(home: newHome)
                    }
                    homes = (try? await homeRepository.fetchHomes()) ?? homes
                }
            }
        }
        .task {
            homes = (try? await homeRepository.fetchHomes()) ?? []
        }
    }
}
#endif
