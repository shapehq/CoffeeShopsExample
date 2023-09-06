import DB
import MapFeatureData
import MapFeatureDomain
import XCTest

final class DBMapPOIServiceTests: XCTestCase {
    func testItUpdatesColorFromStoredRating() async throws {
        let mapPOIService = MockMapPOIService(pointsOfInterest: [
            MapPOI(title: "Foo", latitude: 56, longitude: 10, color: .black)
        ])
        let dbPOIRepository = MockDBPOIRepository(content: [
            MockDBPOI(
                id: DBPOIID(latitude: 56, longitude: 10),
                title: "Foo", 
                latitude: 56,
                longitude: 10,
                rating: .four
            )
        ])
        let service = DBMapPOIService(decorating: mapPOIService, dbPOIRepository: dbPOIRepository)
        let stream = try await service.pointsOfInterest(
            centerLatitude: 54,
            centerLongitude: 8,
            latitudeDelta: 4,
            longitudeDelta: 4
        )
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            for try await pointsOfInterest in stream {
                if let pointOfInterest = pointsOfInterest.first {
                    XCTAssertEqual(pointOfInterest.id, MapPOI.ID(latitude: 56, longitude: 10))
                    XCTAssertEqual(pointOfInterest.title, "Foo")
                    XCTAssertEqual(pointOfInterest.latitude, 56)
                    XCTAssertEqual(pointOfInterest.longitude, 10)
                    XCTAssertEqual(pointOfInterest.color, .green)
                    expectation.fulfill()
                } else {
                    XCTFail("pointOfInterest unavailable")
                    expectation.fulfill()
                }
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }
}
