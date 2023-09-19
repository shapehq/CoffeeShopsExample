import DB
import MapFeatureData
import MapFeatureDomain
import XCTest

final class PersistenceAnnotatingCoffeeShopMarkerServiceTests: XCTestCase {
    func testItUpdatesColorFromStoredRating() async throws {
        let mapCoffeeShopService = MockCoffeeShopMarkerService(coffeeShops: [
            CoffeeShopMarker(title: "Foo", latitude: 56, longitude: 10, color: .black)
        ])
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [
            MockPersistedCoffeeShop(
                id: PersistedCoffeeShopID(latitude: 56, longitude: 10),
                title: "Foo",
                latitude: 56,
                longitude: 10,
                rating: .four
            )
        ])
        let service = PersistenceAnnotatingCoffeeShopMarkerService(
            decorating: mapCoffeeShopService,
            persistedCoffeeShopRepository: persistedCoffeeShopRepository
        )
        let stream = try await service.coffeeShops(
            centerLatitude: 54,
            centerLongitude: 8,
            latitudeDelta: 4,
            longitudeDelta: 4
        )
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            for try await coffeeShops in stream {
                if let coffeeShop = coffeeShops.first {
                    XCTAssertEqual(coffeeShop.id, CoffeeShopMarker.ID(latitude: 56, longitude: 10))
                    XCTAssertEqual(coffeeShop.title, "Foo")
                    XCTAssertEqual(coffeeShop.latitude, 56)
                    XCTAssertEqual(coffeeShop.longitude, 10)
                    XCTAssertEqual(coffeeShop.color, .green)
                    expectation.fulfill()
                } else {
                    XCTFail("coffeeShop unavailable")
                    expectation.fulfill()
                }
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }
}
