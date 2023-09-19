import SwiftData
import SwiftDataDB
import XCTest

final class SwiftDataPOIRepositoryTests: XCTestCase {
    func testItReturnsTheInsertedPOI() {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let repository = SwiftDataPOIRepository(modelContext: context)
        let insertedPOI = repository.addPointOfInterest(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        XCTAssertEqual(insertedPOI.title, "Foo")
        XCTAssertEqual(insertedPOI.latitude, 56)
        XCTAssertEqual(insertedPOI.longitude, 10)
        XCTAssertEqual(insertedPOI.phoneNumber, "12345678")
        XCTAssertEqual(insertedPOI.websiteURL, URL(string: "https://example.com"))
    }

    func testItInsertsPOI() throws {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let repository = SwiftDataPOIRepository(modelContext: context)
        let insertedPOI = repository.addPointOfInterest(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        let fetchedPOI = try repository.pointOfInterest(withID: insertedPOI.id)
        XCTAssertNotNil(fetchedPOI)
    }

    func testItDeletesPOI() throws {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let repository = SwiftDataPOIRepository(modelContext: context)
        let insertedPOI = repository.addPointOfInterest(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        XCTAssertTrue(context.deletedModelsArray.isEmpty)
        repository.deletePointOfInterest(insertedPOI)
        XCTAssertFalse(context.deletedModelsArray.isEmpty)
    }

    func testItFetchesListOfPOIs() async throws {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let repository = SwiftDataPOIRepository(modelContext: context)
        let insertedPOI1 = repository.addPointOfInterest(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        let insertedPOI2 = repository.addPointOfInterest(
            title: "Bar",
            latitude: 82,
            longitude: 32,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            let poiStream = try repository.pointsOfInterest(withIDs: [insertedPOI1.id, insertedPOI2.id])
            for try await pointsOfInterest in poiStream {
                XCTAssertEqual(pointsOfInterest.count, 2)
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }
}
