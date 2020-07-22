// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "query-string-coder",
  platforms: [
    .macOS(.v10_15)
  ],
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "QueryStringCoder",
      targets: ["QueryStringCoder"]),
  ],
  dependencies: [
    .package(url: "https://github.com/SwiftGlide/glide", from: "0.0.9"),
    .package(url: "https://github.com/apple/swift-nio", from: "2.19.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
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
