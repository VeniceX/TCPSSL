// TCPSSLStreamServer.swift
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

public struct TCPSSLStreamServer: StreamServerType {
    public let serverSocket: TCPServerSocket
    public let lowWaterMark: Int
    public let highWaterMark: Int
    public let context: SSLServerContext

    public init(address: String? = nil, port: Int, backlog: Int = 128, lowWaterMark: Int = 1, highWaterMark: Int = 4096, certificate: String, privateKey: String, certificateChain: String? = nil) throws {
        let ip = try IP(localAddress: address, port: port)
        self.serverSocket = try TCPServerSocket(ip: ip, backlog: backlog)
        self.lowWaterMark = lowWaterMark
        self.highWaterMark = highWaterMark
        self.context = try SSLServerContext(
            certificate: certificate,
            privateKey: privateKey,
            certificateChain: certificateChain
        )
    }

    public func accept() throws -> StreamType {
        let socket = try serverSocket.accept()
        let rawStream = TCPStream(socket: socket, lowWaterMark: lowWaterMark, highWaterMark: highWaterMark)
        return try SSLServerStream(context: context, rawStream: rawStream)
    }
}
