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
            checksum: "57a94272c9bb209736ff5fd09c423ff3d7ffc0ecab11e3a99e0a9f05f090c2bf"
        ),
        .binaryTarget(
            name: "RescueBroadcast",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.15/RescueBroadcast.xcframework.zip",
            checksum: "8b04f0f7dd2a3cf234a07df44dcbeb45eea98942f5b980663cff8fa4f4299c78"
        ),
        .binaryTarget(
            name: "LMICoreMedia",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.15/LMICoreMedia.xcframework.zip",
            checksum: "0fdcb622f9be96b547cf01e2b48db50d7400ca580760c7dab1b143993e6d7fc2"
        )
    ]
)