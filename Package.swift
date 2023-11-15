// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "RescueSDK",
    platforms: [
           .iOS(.v15)
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
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.17/RescueCore.xcframework.zip",
            checksum: "4b65c63ccc96ced136e5aa10427ec56a61624c0041181f1c845a01add6646258"
        ),
        .binaryTarget(
            name: "RescueBroadcast",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.17/RescueBroadcast.xcframework.zip",
            checksum: "e0c155eca18669ff9a82f2d94595fd846eb9343aa196a7931227e2a6092e8d93"
        ),
        .binaryTarget(
            name: "LMICoreMedia",
            url: "https://github.com/LogmeinRescue/iOS-SDK/releases/download/5.17/LMICoreMedia.xcframework.zip",
            checksum: "bc5db7aaf5d9a3305c6ac0fd53dbbd3790c586c78f45f00ca5b8fad48ddb9066"
        )
    ]
)
