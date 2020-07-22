// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "query-string-coder",
  platforms: [
    .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "QueryStringCoder",
      targets: ["QueryStringCoder"]),
  ],
  dependencies: [
    .package(url: "https://github.com/SwiftGlide/glide", from: "0.0.9")
  ],
  targets: [
    .target(
      name: "QueryStringCoder",
      dependencies: [
        .product(name: "Glide", package: "glide"),
      ],
      path: "Sources"
    ),
    .testTarget(
      name: "QueryStringCoderTests",
      dependencies: [
        .target(name: "QueryStringCoder"),
      ],
      path: "Tests"
    ),
  ]
)
