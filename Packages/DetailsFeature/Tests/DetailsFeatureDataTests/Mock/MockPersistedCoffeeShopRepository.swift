import AnyAsync
import DB
import Foundation

final class MockPersistedCoffeeShopRepository: PersistedCoffeeShopRepository {
    let coffeeShops: AnyAsyncSequence<[MockPersistedCoffeeShop]>

    private(set) var insertedCoffeeShop: MockPersistedCoffeeShop?
    private(set) var deletedCoffeeShopID: PersistedCoffeeShopID?
    private let content: [MockPersistedCoffeeShop]

    init(content: [MockPersistedCoffeeShop] = []) {
        self.content = content
        self.coffeeShops = AnyAsyncSequence([content])
    }

    func coffeeShop(withID id: PersistedCoffeeShopID) throws -> MockPersistedCoffeeShop? {
        content.first { $0.id == id }
    }

    func coffeeShops(withIDs ids: Set<PersistedCoffeeShopID>) throws -> AnyAsyncSequence<[PersistedCoffeeShopID: MockPersistedCoffeeShop]> {
        AnyAsyncSequence([])
    }

    func addCoffeeShop(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String?,
        websiteURL: URL?
    ) -> MockPersistedCoffeeShop {
        let insertedCoffeeShop = MockPersistedCoffeeShop(
            id: PersistedCoffeeShopID(
                latitude: latitude,
                longitude: longitude
            ),
            title: title,
            latitude: latitude,
            longitude: longitude,
            websiteURL: websiteURL,
            phoneNumber: phoneNumber
        )
        self.insertedCoffeeShop = insertedCoffeeShop
        return insertedCoffeeShop
    }

    func deleteCoffeeShop(_ coffeeShop: MockPersistedCoffeeShop) {
        deletedCoffeeShopID = coffeeShop.id
    }
}
