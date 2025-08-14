#if canImport(SwiftUI)
import SwiftUI

/// Dashboard for a specific home showing upcoming tasks and navigation to assets and tasks.
public struct HomeDashboardView: View {
    public let home: HomeEntity
    private let taskRepository = CoreDataTaskRepository()
    private let assetRepository = CoreDataAssetRepository()
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
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape")
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink(destination: ShareStatusView(home: home)) {
                    Image(systemName: "square.and.arrow.up")
                }
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
                Task {
                    try? await taskRepository.add(task: task)
                    tasks = (try? await taskRepository.fetchTasks(homeID: home.id)) ?? tasks
                }
            }
        }
        .navigationDestination(isPresented: $showEditAsset) {
            EditAssetView(home: home) { asset in
                Task {
                    try? await assetRepository.add(asset: asset)
                    assets = (try? await assetRepository.fetchAssets(homeID: home.id)) ?? assets
                }
            }
        }
        .task {
            async let t = taskRepository.fetchTasks(homeID: home.id)
            async let a = assetRepository.fetchAssets(homeID: home.id)
            tasks = (try? await t) ?? []
            assets = (try? await a) ?? []
        }
    }
}
#endif
