import PackageDescription

let package = Package(
    name: "TCPSSL",
    dependencies: [
        .Package(url: "https://github.com/VeniceX/TCP.git", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/Zewo/OpenSSL.git", majorVersion: 0, minor: 6),
    ]
)
