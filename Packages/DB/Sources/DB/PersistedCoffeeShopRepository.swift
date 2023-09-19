import AnyAsync
import Foundation

public protocol PersistedCoffeeShopRepository {
    associatedtype PersistedCoffeeShopType: PersistedCoffeeShop
    var coffeeShops: AnyAsyncSequence<[PersistedCoffeeShopType]> { get }
    func coffeeShop(withID id: PersistedCoffeeShopID) throws -> PersistedCoffeeShopType?
    func coffeeShops(withIDs ids: Set<PersistedCoffeeShopID>) throws -> AnyAsyncSequence<[PersistedCoffeeShopID: PersistedCoffeeShopType]>
    func addCoffeeShop(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String?,
        websiteURL: URL?
    ) -> PersistedCoffeeShopType
    func deleteCoffeeShop(_ coffeeShop: PersistedCoffeeShopType)
}
