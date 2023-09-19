import DB
import ProfileFeatureDomain

public struct PersistedVisitedCoffeeShop<PersistedCoffeeShopType: PersistedCoffeeShop>: VisitedCoffeeShop {
    public let id: PersistedCoffeeShopID
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let rating: VisitedCoffeeShopRating
    public let note: String?

    let persistedCoffeeShop: PersistedCoffeeShopType

    init(_ persistedCoffeeShop: PersistedCoffeeShopType) {
        self.persistedCoffeeShop = persistedCoffeeShop
        self.id = persistedCoffeeShop.id
        self.title = persistedCoffeeShop.title
        self.latitude = persistedCoffeeShop.latitude
        self.longitude = persistedCoffeeShop.longitude
        self.rating = VisitedCoffeeShopRating(persistedCoffeeShop.rating)
        self.note = persistedCoffeeShop.note
    }
}
