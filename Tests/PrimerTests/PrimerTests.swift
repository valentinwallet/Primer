import XCTest
@testable import Primer

final class PrimerTests: XCTestCase {
    func testExample() throws {
        XCTAssertTrue(Primer.build() is PrimerCheckoutViewController)
    }
}
