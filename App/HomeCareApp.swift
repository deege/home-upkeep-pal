#if canImport(SwiftUI)
import SwiftUI
import HomeCare

@main
struct HomeCareApp: App {
    var body: some Scene {
        WindowGroup {
            HomesListView()
        }
    }
}
#endif
