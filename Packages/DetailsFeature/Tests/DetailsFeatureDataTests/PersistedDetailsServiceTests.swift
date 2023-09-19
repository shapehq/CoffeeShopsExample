import DB
import DetailsFeatureData
import DetailsFeatureDomain
import XCTest

final class PersistedDetailsServiceTests: XCTestCase {
    func testItReturnsDetailsWhenCoffeeShopNotFoundInDB() async throws {
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [])
        let service = PersistedDetailsService(persistedCoffeeShopRepository: persistedCoffeeShopRepository)
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: nil,
            websiteURL: nil
        )
        let details = try await service.coffeeShopDetails(for: sparseDetails)
        XCTAssertEqual(details.title, sparseDetails.title)
        XCTAssertEqual(details.latitude, sparseDetails.latitude)
        XCTAssertEqual(details.longitude, sparseDetails.longitude)
        XCTAssertEqual(details.phoneNumber, sparseDetails.phoneNumber)
        XCTAssertEqual(details.websiteURL, sparseDetails.websiteURL)
    }

    func testItReturnsDetailsWhenCoffeeShopFoundInDB() async throws {
        let persistedCoffeeShopRepository = MockPersistedCoffeeShopRepository(content: [
            MockPersistedCoffeeShop(
                id: PersistedCoffeeShopID(latitude: 56, longitude: 10),
                title: "Foo",
                latitude: 56,
                longitude: 10
            )
        ])
        let service = PersistedDetailsService(persistedCoffeeShopRepository: persistedCoffeeShopRepository)
        let sparseDetails = SparseDetails(
            title: "Foo",
            latitude: 56,
            longitude: 10
        )
        let details = try await service.coffeeShopDetails(for: sparseDetails)
        XCTAssertEqual(details.title, sparseDetails.title)
        XCTAssertEqual(details.latitude, sparseDetails.latitude)
        XCTAssertEqual(details.longitude, sparseDetails.longitude)
        XCTAssertEqual(details.phoneNumber, sparseDetails.phoneNumber)
        XCTAssertEqual(details.websiteURL, sparseDetails.websiteURL)
    }
}
