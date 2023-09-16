import DB
import ProfileFeatureData
import XCTest

final class DBVisitedPOIsRepositoryTests: XCTestCase {
    func testItStoresVisitedCoffeeShop() async throws {
        let mockDBPPOI = MockDBPOI(
            id: DBPOIID(latitude: 56, longitude: 10),
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let dbPOIRepository = MockDBPOIRepository(content: [mockDBPPOI])
        let repository = DBVisitedPOIsRepository(dbPOIRepository: dbPOIRepository)
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            _ = repository.visitedPOIs
            try await Task.sleep(for: .seconds(0.1))
            if let visitedCoffeeShop = repository.visitedPOIs.first {
                XCTAssertEqual(visitedCoffeeShop.id, DBPOIID(latitude: 56, longitude: 10))
                XCTAssertEqual(visitedCoffeeShop.title, "Foo")
                XCTAssertEqual(visitedCoffeeShop.latitude, 56)
                XCTAssertEqual(visitedCoffeeShop.longitude, 10)
                expectation.fulfill()
            } else {
                XCTFail("visitedPOIs is empty")
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }

    func testItDeletesPointOfInterestFromRepository() async throws {
        let idToDelete = DBPOIID(latitude: 56, longitude: 10)
        let mockDBPPOI = MockDBPOI(
            id: idToDelete,
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let dbPOIRepository = MockDBPOIRepository(content: [mockDBPPOI])
        let repository = DBVisitedPOIsRepository(dbPOIRepository: dbPOIRepository)
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            _ = repository.visitedPOIs
            try await Task.sleep(for: .seconds(0.1))
            if let poi = repository.visitedPOIs.first {
                repository.deleteVisitedPOI(poi)
                XCTAssertEqual(dbPOIRepository.deletedPOIID, idToDelete)
                expectation.fulfill()
            } else {
                XCTFail("visitedPOIs is empty")
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }
}
