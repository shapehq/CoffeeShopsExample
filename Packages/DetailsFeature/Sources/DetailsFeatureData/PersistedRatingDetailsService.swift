import DB
import DetailsFeatureDomain

public final actor PersistedDetailsService<
    PersistedCoffeeShopRepositoryType: PersistedCoffeeShopRepository
>: DetailsService {
    private let persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType

    public init(persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType) {
        self.persistedCoffeeShopRepository = persistedCoffeeShopRepository
    }

    public func coffeeShopDetails(for sparseDetails: SparseDetails) async throws -> some Details {
        let id = PersistedCoffeeShopID(latitude: sparseDetails.latitude, longitude: sparseDetails.longitude)
        if let persistedCoffeeShop = try persistedCoffeeShopRepository.coffeeShop(withID: id) {
            return PersistedDetails(
                sparseDetails,
                persistedCoffeeShop: persistedCoffeeShop,
                persistedCoffeeShopRepository: persistedCoffeeShopRepository
            )
        } else {
            return PersistedDetails(sparseDetails, persistedCoffeeShopRepository: persistedCoffeeShopRepository)
        }
    }
}
