// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "RescueSDK",
    products: [
        .library(
            name: "RescueSDK",
            targets: ["RescueSDK"]
        ),
    ],
    targets: [
        .target(
            name: "RescueSDK",
            dependencies: [
                .target(name: "RescueCoreWrapper"),
                .target(name: "RescueBroadcastWrapper"),
                .target(name: "LMICoreMediaWrapper"),
            ]
        ),
        .target(
            name: "RescueCoreWrapper",
            dependencies: [
                .target(name: "RescueCore")
            ]
        ),
        .target(
            name: "RescueBroadcastWrapper",
            dependencies: [
                .target(name: "RescueBroadcast"),
            ]
        ),
        .target(
            name: "LMICoreMediaWrapper",
            dependencies: [
                .target(name: "LMICoreMedia"),
                .target(name: "RescueCore")
            ]
        ),
        .binaryTarget(
            name: "RescueCore",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.14/RescueCore.xcframework.zip",
            checksum: "a94848c885c7730840e6ab8cf51a06464644525fbe0df2e161ca521058b27be9"
        ),
        .binaryTarget(
            name: "RescueBroadcast",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.14/RescueBroadcast.xcframework.zip",
            checksum: "5caa215f195c92da6aab5fa40fe62f6e089ac3458b20dad4382c65b71b439a96"
        ),
        .binaryTarget(
            name: "LMICoreMedia",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.14/LMICoreMedia.xcframework.zip",
            checksum: "25f10eca102b69a96a89ca5f5b6bb2ce5c41a519dc771933891185b497ebdf79"
        )
    ]
)
