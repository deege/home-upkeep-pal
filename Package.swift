// swift-tools-version:5.9
import PackageDescription

var products: [Product] = [
    .library(name: "HomeCare", targets: ["HomeCare"])
]

var targets: [Target] = [
    .target(
        name: "HomeCare",
        path: "Sources",
        resources: [
            .process("Persistence/Model")
        ]
    ),
    .testTarget(
        name: "HomeCareTests",
        dependencies: ["HomeCare"],
        path: "Tests/HomeCareTests"
    )
]

#if !os(Linux)
products.append(
    .iOSApplication(
        name: "HomeCare",
        targets: ["HomeCareApp"],
        bundleIdentifier: "com.example.HomeCare",
        teamIdentifier: "ABCDE12345",
        displayVersion: "1.0",
        bundleVersion: "1",
        appIcon: .placeholder(),
        accentColor: .presetColor(.blue),
        supportedDeviceFamilies: [
            .phone,
            .pad
        ],
        supportedInterfaceOrientations: [
            .portrait,
            .landscapeLeft,
            .landscapeRight
        ],
        capabilities: [
            .iCloud()
        ]
    )
)

targets.append(
    .executableTarget(
        name: "HomeCareApp",
        dependencies: ["HomeCare"],
        path: "App"
    )
)
#endif
let package = Package(
    name: "HomeCare",
    platforms: [
        .iOS(.v17)
    ],
)
