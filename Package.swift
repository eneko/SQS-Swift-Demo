// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SQSDemo",
    products: [
        .executable(name: "consumer", targets: ["Consumer"]),
        .executable(name: "producer", targets: ["Producer"])
    ],
    dependencies: [
        .package(url: "https://github.com/soto-project/soto", from: "5.0.0")
    ],
    targets: [
        .target(name: "Consumer", dependencies: [
            .product(name: "SotoSQS", package: "soto")
        ]),
        .target(name: "Producer", dependencies: [
            .product(name: "SotoSQS", package: "soto")
        ])
    ]
)
