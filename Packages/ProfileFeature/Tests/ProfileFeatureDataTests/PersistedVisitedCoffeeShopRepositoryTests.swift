import DB
import ProfileFeatureData
import XCTest

final class PersistedVisitedCoffeeShopRepositoryTests: XCTestCase {
    func testItStoresVisitedCoffeeShop() async throws {
        let mockDBPCoffeeShop = MockPersistedCoffeeShop(
            id: PersistedCoffeeShopID(latitude: 56, longitude: 10),
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [mockDBPCoffeeShop])
        let repository = PersistedVisitedCoffeeShopRepository(persistedCoffeeShopRepository: persistedCoffeeShopRepository)
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            _ = repository.visitedCoffeeShops
            try await Task.sleep(for: .seconds(0.1))
            if let visitedCoffeeShop = repository.visitedCoffeeShops.first {
                XCTAssertEqual(visitedCoffeeShop.id, PersistedCoffeeShopID(latitude: 56, longitude: 10))
                XCTAssertEqual(visitedCoffeeShop.title, "Foo")
                XCTAssertEqual(visitedCoffeeShop.latitude, 56)
                XCTAssertEqual(visitedCoffeeShop.longitude, 10)
                expectation.fulfill()
            } else {
                XCTFail("visitedCoffeeShops is empty")
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }

    func testItDeletesCoffeeShopFromRepository() async throws {
        let idToDelete = PersistedCoffeeShopID(latitude: 56, longitude: 10)
        let mockDBPCoffeeShop = MockPersistedCoffeeShop(
            id: idToDelete,
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [mockDBPCoffeeShop])
        let repository = PersistedVisitedCoffeeShopRepository(persistedCoffeeShopRepository: persistedCoffeeShopRepository)
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            _ = repository.visitedCoffeeShops
            try await Task.sleep(for: .seconds(0.1))
            if let coffeeShop = repository.visitedCoffeeShops.first {
                repository.deleteVisitedCoffeeShop(coffeeShop)
                XCTAssertEqual(persistedCoffeeShopRepository.deletedCoffeeShopID, idToDelete)
                expectation.fulfill()
            } else {
                XCTFail("visitedCoffeeShops is empty")
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }
}
