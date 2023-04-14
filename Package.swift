// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "RescueSDK",
    platforms: [
           .iOS(.v12)
    ],
    products: [
        .library(
            name: "RescueCore",
            targets: ["RescueCore"]
        ),
        .library(
            name: "RescueBroadcast",
            targets: ["RescueBroadcast"]
        ),
        .library(
            name: "LMICoreMedia",
            targets: ["LMICoreMedia"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "RescueCore",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.15/RescueCore.xcframework.zip",
            checksum: "c1cb92caf12bc9d4456245e5b304b56483e86e7a1a0aa2d9a90176be825d39e3"
        ),
        .binaryTarget(
            name: "RescueBroadcast",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.15/RescueBroadcast.xcframework.zip",
            checksum: "03572ec5d434e4cc472e119fef5409a937436a8675e9bf775d91616e34028e3f"
        ),
        .binaryTarget(
            name: "LMICoreMedia",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.15/LMICoreMedia.xcframework.zip",
            checksum: "42d94e914885b10a3e2f477554e74385e9918a1eb8fb8736ca11925526a0652a"
        )
    ]
)