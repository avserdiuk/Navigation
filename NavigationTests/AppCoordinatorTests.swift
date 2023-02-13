
import XCTest
@testable import Navigation

final class AppCoordinatorTests: XCTestCase {

    var sut : AppCoordinator? = nil

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AppCoordinator(transitionHandler: UITabBarController())
        
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testTrueStartAppCoordinator() throws {

        sut?.start()

        XCTAssertEqual(sut?.child.count, 2)

    }

    func testTrueStartFeedCoordinator() throws {

        sut?.startFeedCoordinator()

        XCTAssertEqual(sut?.child.count, 1)

    }

    func testTrueStartProfileCoordinator() throws {

        sut?.startProfileCoordinator()

        XCTAssertEqual(sut?.child.count, 1)

    }
}
