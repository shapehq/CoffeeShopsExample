import DB
@testable import DetailsFeatureData
import DetailsFeatureDomain
import XCTest

final class DBWrappingDetailsTests: XCTestCase {
    func testItInsertsPOIIntoDatabaseWhenEditingRating() async throws {
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: nil,
            websiteURL: nil
        )
        let dbPOIRepository = MockDBPOIRepository(content: [])
        let details = DBWrappingDetails(sparseDetails, dbPOIRepository: dbPOIRepository)
        details.rating = .four
        XCTAssertNotNil(dbPOIRepository.insertedPOI)
    }

    func testItInsertsPOIIntoDatabaseWhenEditingNote() async throws {
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: nil,
            websiteURL: nil
        )
        let dbPOIRepository = MockDBPOIRepository(content: [])
        let details = DBWrappingDetails(sparseDetails, dbPOIRepository: dbPOIRepository)
        details.note = "Hello world!"
        XCTAssertNotNil(dbPOIRepository.insertedPOI)
    }

    func testItInsertsPOIIntoDatabaseWhenEditingRatingIfPOIAlreadyExists() async throws {
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: nil,
            websiteURL: nil
        )
        let dbPOI = MockDBPOI(
            id: DBPOIID(latitude: 56, longitude: 10),
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let dbPOIRepository = MockDBPOIRepository(content: [])
        let details = DBWrappingDetails(sparseDetails, dbPOI: dbPOI, dbPOIRepository: dbPOIRepository)
        details.rating = .five
        XCTAssertNil(dbPOIRepository.insertedPOI)
    }

    func testItInsertsPOIIntoDatabaseWhenEditingNoteIfPOIAlreadyExists() async throws {
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let dbPOI = MockDBPOI(
            id: DBPOIID(latitude: 56, longitude: 10),
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let dbPOIRepository = MockDBPOIRepository(content: [])
        let details = DBWrappingDetails(sparseDetails, dbPOI: dbPOI, dbPOIRepository: dbPOIRepository)
        details.note = "Hello world!"
        XCTAssertNil(dbPOIRepository.insertedPOI)
    }
}
