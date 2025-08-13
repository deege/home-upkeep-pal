// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "HomeCare",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "HomeCare", targets: ["HomeCare"])
    ],
    targets: [
        .target(
            name: "HomeCare",
            path: "Sources"
        ),
        .testTarget(
            name: "HomeCareTests",
            dependencies: ["HomeCare"],
            path: "Tests/HomeCareTests"
        )
    ]
)
