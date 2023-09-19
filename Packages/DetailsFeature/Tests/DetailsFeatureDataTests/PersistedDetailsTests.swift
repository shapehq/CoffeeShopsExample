import DB
@testable import DetailsFeatureData
import DetailsFeatureDomain
import XCTest

final class PersistedDetailsTests: XCTestCase {
    func testItInsertsCoffeeShopIntoDatabaseWhenEditingRating() async throws {
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: nil,
            websiteURL: nil
        )
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [])
        let details = PersistedDetails(sparseDetails, persistedCoffeeShopRepository: persistedCoffeeShopRepository)
        details.rating = .four
        XCTAssertNotNil(persistedCoffeeShopRepository.insertedCoffeeShop)
    }

    func testItInsertsCoffeeShopIntoDatabaseWhenEditingNote() async throws {
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: nil,
            websiteURL: nil
        )
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [])
        let details = PersistedDetails(sparseDetails, persistedCoffeeShopRepository: persistedCoffeeShopRepository)
        details.note = "Hello world!"
        XCTAssertNotNil(persistedCoffeeShopRepository.insertedCoffeeShop)
    }

    func testItInsertsCoffeeShopIntoDatabaseWhenEditingRatingIfCoffeeShopAlreadyExists() async throws {
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: nil,
            websiteURL: nil
        )
        let persistedCoffeeShop = MockPersistedCoffeeShop(
            id: PersistedCoffeeShopID(latitude: 56, longitude: 10),
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [])
        let details = PersistedDetails(
            sparseDetails,
            persistedCoffeeShop: persistedCoffeeShop,
            persistedCoffeeShopRepository: persistedCoffeeShopRepository
        )
        details.rating = .five
        XCTAssertNil(persistedCoffeeShopRepository.insertedCoffeeShop)
    }

    func testItInsertsCoffeeShopIntoDatabaseWhenEditingNoteIfCoffeeShopAlreadyExists() async throws {
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let persistedCoffeeShop = MockPersistedCoffeeShop(
            id: PersistedCoffeeShopID(latitude: 56, longitude: 10),
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [])
        let details = PersistedDetails(
            sparseDetails,
            persistedCoffeeShop: persistedCoffeeShop,
            persistedCoffeeShopRepository: persistedCoffeeShopRepository
        )
        details.note = "Hello world!"
        XCTAssertNil(persistedCoffeeShopRepository.insertedCoffeeShop)
    }
}
