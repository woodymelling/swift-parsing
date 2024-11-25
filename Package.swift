// swift-tools-version:6.0

import PackageDescription

let package = Package(
  name: "swift-parsing",
  platforms: [
    .iOS(.v18),
    .macOS(.v14),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "Parsing",
      targets: ["Parsing"]
    ),
    .library(name: "Conversions", targets: ["Parsing"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.3.3"),
    .package(url: "https://github.com/google/swift-benchmark", from: "0.1.1"),
  ],
  targets: [
    .target(
      name: "Parsing",
      dependencies: [
        .product(name: "CasePaths", package: "swift-case-paths"),
        .product(name: "CustomDump", package: "swift-custom-dump"),
        .target(name: "Conversions")
      ],
      swiftSettings: [.swiftLanguageMode(.v5)]
    ),
    .target(
      name: "Conversions",
      dependencies: [
        .product(name: "CustomDump", package: "swift-custom-dump")
      ]
    ),
    .testTarget(
      name: "ParsingTests",
      dependencies: [
        "Parsing"
      ]
    ),
    .executableTarget(
      name: "swift-parsing-benchmark",
      dependencies: [
        "Parsing",
        .product(name: "Benchmark", package: "swift-benchmark"),
      ]
    ),
  ]
)
