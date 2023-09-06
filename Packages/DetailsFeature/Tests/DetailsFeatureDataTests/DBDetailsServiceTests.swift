import DB
import DetailsFeatureData
import DetailsFeatureDomain
import XCTest

final class DBDetailsServiceTests: XCTestCase {
    func testItReturnsDetailsWhenPOINotFoundInDB() async throws {
        let dbPOIRepository = MockDBPOIRepository(content: [])
        let service = DBDetailsService(dbPOIRepository: dbPOIRepository)
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: nil,
            websiteURL: nil
        )
        let details = try await service.pointOfInterestDetails(for: sparseDetails)
        XCTAssertEqual(details.title, sparseDetails.title)
        XCTAssertEqual(details.latitude, sparseDetails.latitude)
        XCTAssertEqual(details.longitude, sparseDetails.longitude)
        XCTAssertEqual(details.phoneNumber, sparseDetails.phoneNumber)
        XCTAssertEqual(details.websiteURL, sparseDetails.websiteURL)
    }

    func testItReturnsDetailsWhenPOIFoundInDB() async throws {
        let dbPOIRepository = MockDBPOIRepository(content: [
            MockDBPOI(
                id: DBPOIID(latitude: 56, longitude: 10),
                title: "Foo",
                latitude: 56,
                longitude: 10
            )
        ])
        let service = DBDetailsService(dbPOIRepository: dbPOIRepository)
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let details = try await service.pointOfInterestDetails(for: sparseDetails)
        XCTAssertEqual(details.title, sparseDetails.title)
        XCTAssertEqual(details.latitude, sparseDetails.latitude)
        XCTAssertEqual(details.longitude, sparseDetails.longitude)
        XCTAssertEqual(details.phoneNumber, sparseDetails.phoneNumber)
        XCTAssertEqual(details.websiteURL, sparseDetails.websiteURL)
    }
}
