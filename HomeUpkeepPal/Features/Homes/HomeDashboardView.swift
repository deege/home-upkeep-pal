#if canImport(SwiftUI)
import SwiftUI

/// Dashboard for a specific home showing upcoming tasks and navigation to assets and tasks.
public struct HomeDashboardView: View {
    public let home: HomeEntity
    @State private var selection: Tab = .tasks
    @State private var showEditTask = false
    @State private var showEditAsset = false
    @State private var tasks: [TaskEntity] = []
    @State private var assets: [AssetEntity] = []

    enum Tab {
        case tasks
        case assets
    }

    public init(home: HomeEntity) { self.home = home }

    public var body: some View {
        TabView(selection: $selection) {
            TasksListView(home: home, tasks: $tasks)
                .tabItem { Label("Tasks", systemImage: "checklist") }
                .tag(Tab.tasks)

            AssetsListView(home: home, assets: $assets)
                .tabItem { Label("Assets", systemImage: "cube") }
                .tag(Tab.assets)
        }
        .navigationTitle(selection == .tasks ? "Tasks" : "Assets")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    switch selection {
                    case .tasks: showEditTask = true
                    case .assets: showEditAsset = true
                    }
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationDestination(isPresented: $showEditTask) {
            EditTaskView(home: home) { task in
                tasks.append(task)
            }
        }
        .navigationDestination(isPresented: $showEditAsset) {
            EditAssetView(home: home) { asset in
                assets.append(asset)
            }
        }
    }
}
#endif
