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
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.16/RescueCore.xcframework.zip",
            checksum: "c8b7bfe59363b462e16523e078cb615c93cb407419abce674cbcd46a43ca72c5"
        ),
        .binaryTarget(
            name: "RescueBroadcast",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.16/RescueBroadcast.xcframework.zip",
            checksum: "b3ac1d27a1137130549db1c954112086322437b98361698ce6d5c14f37d245cc"
        ),
        .binaryTarget(
            name: "LMICoreMedia",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.16/LMICoreMedia.xcframework.zip",
            checksum: "93fa49c3a2192616da840e562222cc47b9e26bf0816e970e85c3ac48ae3c6bed"
        )
    ]
)