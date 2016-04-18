// TCPSSLServer.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

@_exported import TCP
@_exported import OpenSSL

public struct TCPSSLServer: Host {
    public let server: TCPServer
    public let context: SSLServerContext

    public init(host: String = "0.0.0.0", port: Int, backlog: Int = 128, reusePort: Bool = false, certificate: String, privateKey: String, certificateChain: String? = nil) throws {
        self.server = try TCPServer(host: host, port: port, backlog: backlog, reusePort: reusePort)
        self.context = try SSLServerContext(
            certificate: certificate,
            privateKey: privateKey,
            certificateChain: certificateChain
        )
    }

    public func accept(timingOut deadline: Double) throws -> Stream {
        let stream = try server.accept(timingOut: deadline)
        return try SSLServerStream(context: context, rawStream: stream)
    }
}
