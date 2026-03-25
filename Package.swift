// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "VtvIdSdkBinary",
    platforms: [.iOS(.v15), .tvOS(.v16)],
    products: [
        .library(name: "VtvIdSdkBinary", targets: ["VtvIdSdk"])
    ],
    targets: [
        .binaryTarget(
            name: "VtvIdSdk",
            path: "VtvIdSdk.xcframework.zip"
        )
    ]
)
