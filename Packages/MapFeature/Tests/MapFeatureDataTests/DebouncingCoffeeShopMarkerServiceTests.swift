import DB
import MapFeatureData
import MapFeatureDomain
import XCTest

final class DebouncingCoffeeShopMarkerServiceTests: XCTestCase {
    func testItDebouncesRequestsWhenPreviousTaskIsCancelled() async throws {
        let markerService = MockCoffeeShopMarkerService(coffeeShops: [])
        let service = DebouncingCoffeeShopMarkerService(decorating: markerService)
        let expectation = XCTestExpectation(description: "timeout")
        let t1 = Task {
            _ = try await service.coffeeShops(
                centerLatitude: 54,
                centerLongitude: 8,
                latitudeDelta: 4,
                longitudeDelta: 4
            )
        }
        t1.cancel()
        let t2 = Task {
            _ = try await service.coffeeShops(
                centerLatitude: 54,
                centerLongitude: 8,
                latitudeDelta: 4,
                longitudeDelta: 4
            )
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(markerService.numberOfInvocations, 1)
        t2.cancel()
    }

    func testItPerformsAllRequestsWhenTasksAreNotCancelled() async throws {
        let markerService = MockCoffeeShopMarkerService(coffeeShops: [])
        let service = DebouncingCoffeeShopMarkerService(decorating: markerService)
        let expectation = XCTestExpectation(description: "timeout")
        let t1 = Task {
            _ = try await service.coffeeShops(
                centerLatitude: 54,
                centerLongitude: 8,
                latitudeDelta: 4,
                longitudeDelta: 4
            )
        }
        let t2 = Task {
            _ = try await service.coffeeShops(
                centerLatitude: 54,
                centerLongitude: 8,
                latitudeDelta: 4,
                longitudeDelta: 4
            )
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(markerService.numberOfInvocations, 2)
        t1.cancel()
        t2.cancel()
    }
}
