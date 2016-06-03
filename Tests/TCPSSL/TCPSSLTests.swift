import XCTest
@testable import TCPSSL

class TCPSSLTests: XCTestCase {
    func testReality() {
        XCTAssert(2 + 2 == 4, "Something is severely wrong here.")
    }
}

extension TCPSSLTests {
    static var allTests : [(String, (TCPSSLTests) -> () throws -> Void)] {
        return [
           ("testReality", testReality),
        ]
    }
}
