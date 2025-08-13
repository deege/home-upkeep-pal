#if canImport(SwiftUI)
import SwiftUI

/// Dashboard for a specific home showing upcoming tasks and navigation to assets and tasks.
public struct HomeDashboardView: View {
    public let home: HomeEntity
    public init(home: HomeEntity) { self.home = home }

    public var body: some View {
        TabView {
            TasksListView(home: home)
                .tabItem { Label("Tasks", systemImage: "checklist") }
            AssetsListView(home: home)
                .tabItem { Label("Assets", systemImage: "cube") }
        }
        .navigationTitle(home.name)
    }
}
#endif
