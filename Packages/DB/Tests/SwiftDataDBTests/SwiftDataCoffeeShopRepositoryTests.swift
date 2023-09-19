import SwiftData
import SwiftDataDB
import XCTest

final class SwiftDataCoffeeShopRepositoryTests: XCTestCase {
    func testItReturnsTheInsertedCoffeeShop() {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let repository = SwiftDataCoffeeShopRepository(modelContext: context)
        let insertedCoffeeShop = repository.addCoffeeShop(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        XCTAssertEqual(insertedCoffeeShop.title, "Foo")
        XCTAssertEqual(insertedCoffeeShop.latitude, 56)
        XCTAssertEqual(insertedCoffeeShop.longitude, 10)
        XCTAssertEqual(insertedCoffeeShop.phoneNumber, "12345678")
        XCTAssertEqual(insertedCoffeeShop.websiteURL, URL(string: "https://example.com"))
    }

    func testItInsertsCoffeeShop() throws {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let repository = SwiftDataCoffeeShopRepository(modelContext: context)
        let insertedCoffeeShop = repository.addCoffeeShop(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        let fetchedCoffeeShop = try repository.coffeeShop(withID: insertedCoffeeShop.id)
        XCTAssertNotNil(fetchedCoffeeShop)
    }

    func testItDeletesCoffeeShop() throws {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let repository = SwiftDataCoffeeShopRepository(modelContext: context)
        let insertedCoffeeShop = repository.addCoffeeShop(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        XCTAssertTrue(context.deletedModelsArray.isEmpty)
        repository.deleteCoffeeShop(insertedCoffeeShop)
        XCTAssertFalse(context.deletedModelsArray.isEmpty)
    }

    func testItFetchesListOfCoffeeShops() async throws {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let repository = SwiftDataCoffeeShopRepository(modelContext: context)
        let insertedCoffeeShop1 = repository.addCoffeeShop(
            title: "Foo",
            latitude: 56,
            longitude: 10,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        let insertedCoffeeShop2 = repository.addCoffeeShop(
            title: "Bar",
            latitude: 82,
            longitude: 32,
            phoneNumber: "12345678",
            websiteURL: URL(string: "https://example.com")
        )
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            let coffeeShopsStream = try repository.coffeeShops(withIDs: [insertedCoffeeShop1.id, insertedCoffeeShop2.id])
            for try await coffeeShops in coffeeShopsStream {
                XCTAssertEqual(coffeeShops.count, 2)
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }
}
