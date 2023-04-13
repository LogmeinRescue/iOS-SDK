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
            checksum: "106cbf96996ea8a1b5fa00ac5c622dc316ad96f63bf1a4702a97c3d4879a1040"
        ),
        .binaryTarget(
            name: "RescueBroadcast",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.15/RescueBroadcast.xcframework.zip",
            checksum: "dba2d7e0add7a5e29d277eb41cefe7748c5ce90011e5480594e1cf43a1a13645"
        ),
        .binaryTarget(
            name: "LMICoreMedia",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.15/LMICoreMedia.xcframework.zip",
            checksum: "2c6c81fde6232a5c1a0f91270d9f7c8c9004b3bf3df6eab58d0d479d82740f7f"
        )
    ]
)