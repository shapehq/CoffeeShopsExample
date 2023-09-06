import DB
import MapFeatureData
import MapFeatureDomain
import XCTest

final class DebouncingMapPOIServiceTests: XCTestCase {
    func testItDebouncesRequestsWhenPreviousTaskIsCancelled() async throws {
        let mapPOIService = MockMapPOIService(pointsOfInterest: [])
        let service = DebouncingMapPOIService(decorating: mapPOIService)
        let expectation = XCTestExpectation(description: "timeout")
        let t1 = Task {
            _ = try await service.pointsOfInterest(
                centerLatitude: 54,
                centerLongitude: 8,
                latitudeDelta: 4,
                longitudeDelta: 4
            )
        }
        t1.cancel()
        let t2 = Task {
            _ = try await service.pointsOfInterest(
                centerLatitude: 54,
                centerLongitude: 8,
                latitudeDelta: 4,
                longitudeDelta: 4
            )
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(mapPOIService.numberOfInvocations, 1)
        t2.cancel()
    }

    func testItPerformsAllRequestsWhenTasksAreNotCancelled() async throws {
        let mapPOIService = MockMapPOIService(pointsOfInterest: [])
        let service = DebouncingMapPOIService(decorating: mapPOIService)
        let expectation = XCTestExpectation(description: "timeout")
        let t1 = Task {
            _ = try await service.pointsOfInterest(
                centerLatitude: 54,
                centerLongitude: 8,
                latitudeDelta: 4,
                longitudeDelta: 4
            )
        }
        let t2 = Task {
            _ = try await service.pointsOfInterest(
                centerLatitude: 54,
                centerLongitude: 8,
                latitudeDelta: 4,
                longitudeDelta: 4
            )
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(mapPOIService.numberOfInvocations, 2)
        t1.cancel()
        t2.cancel()
    }
}
