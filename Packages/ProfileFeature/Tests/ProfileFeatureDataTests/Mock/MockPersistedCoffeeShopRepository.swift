import AnyAsync
import DB
import Foundation

final class MockPersistedCoffeeShopRepository: PersistedCoffeeShopRepository {
    let coffeeShops: AnyAsyncSequence<[MockPersistedCoffeeShop]>

    private(set) var deletedCoffeeShopID: PersistedCoffeeShopID?

    init(content: [MockPersistedCoffeeShop] = []) {
        coffeeShops = AnyAsyncSequence([content])
    }

    func coffeeShop(withID id: PersistedCoffeeShopID) throws -> MockPersistedCoffeeShop? {
        nil
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
        MockPersistedCoffeeShop(
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
    }

    func deleteCoffeeShop(_ coffeeShop: MockPersistedCoffeeShop) {
        deletedCoffeeShopID = coffeeShop.id
    }
}
