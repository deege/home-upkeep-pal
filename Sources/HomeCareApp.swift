#if canImport(SwiftUI)
import SwiftUI

@main
struct HomeCareApp: App {
    var body: some Scene {
        WindowGroup {
            HomesListView()
        }
    }
}
#endif
