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
    @State private var editingAsset: AssetEntity? = nil
    @State private var tasks: [TaskEntity] = []
    @State private var assets: [AssetEntity] = []

    enum Tab {
        case tasks
        case assets
    }

    public init(home: HomeEntity) { self.home = home }

    public var body: some View {
        ZStack {
            TabView(selection: $selection) {
                TasksListView(home: home, tasks: $tasks)
                    .tabItem { Label("Tasks", systemImage: "checklist") }
                    .tag(Tab.tasks)

                AssetsListView(home: home, assets: $assets) { asset in
                    editingAsset = asset
                    showEditAsset = true
                }
                    .tabItem { Label("Assets", systemImage: "cube") }
                    .tag(Tab.assets)
            }

            NavigationLink(isActive: $showEditTask) {
                EditTaskView(home: home) { task in
                    Task {
                        try? await taskRepository.add(task: task)
                        tasks = (try? await taskRepository.fetchTasks(homeID: home.id)) ?? tasks
                    }
                }
            } label: { EmptyView() }

            NavigationLink(isActive: $showEditAsset) {
                EditAssetView(home: home, asset: editingAsset) { asset in
                    Task {
                        if let _ = editingAsset {
                            try? await assetRepository.update(asset: asset)
                            if let idx = assets.firstIndex(where: { $0.id == asset.id }) {
                                assets[idx] = asset
                            }
                        } else {
                            try? await assetRepository.add(asset: asset)
                            assets = (try? await assetRepository.fetchAssets(homeID: home.id)) ?? assets
                        }
                    }
                }
            } label: { EmptyView() }
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
                    case .tasks:
                        showEditTask = true
                    case .assets:
                        editingAsset = nil
                        showEditAsset = true
                    }
                }) {
                    Image(systemName: "plus")
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
