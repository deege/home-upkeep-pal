# HomeUpkeepPal (HomeCare)

HomeUpkeepPal is a SwiftUI reference implementation for tracking home maintenance tasks and assets. The app is offline first and syncs via Core Data + CloudKit. It demonstrates a clean separation between the domain model and platform specific code so future Android or Web clients can reuse core logic.

## Features
- Create multiple homes and share them with family via iCloud
- Track assets like appliances or paint colors
- Schedule recurring maintenance tasks with due grouping
- CSV export for tasks and assets
- Local daily summary notifications

## Architecture
```
Domain ── Pure Swift entities & use cases
Persistence ── Core Data + CloudKit repositories
Services ── Notifications, CSV export, image storage
Features ── SwiftUI screens for Homes, Tasks, Assets, Sharing, Settings
```
The package exposes a `HomeCare` library with the domain and service layer. SwiftUI views are wrapped in `#if canImport(SwiftUI)` so the core can compile on Linux for unit testing.

## Running Tests
```
swift test
```

## Building the iOS App
Open `HomeCare` in Xcode 15 or later and run the `HomeCareApp` target on iOS 17.

## CloudKit Setup
The app uses the default iCloud container. In Xcode, enable the iCloud capability with CloudKit and allow CloudKit sharing. Create the necessary record types in the CloudKit dashboard if running on a new container.

## License
See [LICENSE](LICENSE).
