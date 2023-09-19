import AnyAsync
import DB
import Observation
import ProfileFeatureDomain

@Observable
public final class PersistedVisitedCoffeeShopRepository<
    PersistedCoffeeShopRepositoryType: PersistedCoffeeShopRepository
>: VisitedCoffeeShopRepository {
    public var visitedCoffeeShops: [PersistedVisitedCoffeeShop<PersistedCoffeeShopRepositoryType.PersistedCoffeeShopType>] {
        if fetchTask == nil {
            fetchCoffeeShops()
        }
        return _visitedCoffeeShops
    }

    private var _visitedCoffeeShops: [PersistedVisitedCoffeeShop<PersistedCoffeeShopRepositoryType.PersistedCoffeeShopType>] = []

    private let persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType
    private var fetchTask: Task<Void, Never>?

    public init(persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType) {
        self.persistedCoffeeShopRepository = persistedCoffeeShopRepository
    }

    public func deleteVisitedCoffeeShop(
        _ coffeeShop: PersistedVisitedCoffeeShop<PersistedCoffeeShopRepositoryType.PersistedCoffeeShopType>
    ) {
        persistedCoffeeShopRepository.deleteCoffeeShop(coffeeShop.persistedCoffeeShop)
    }
}

private extension PersistedVisitedCoffeeShopRepository {
    private func fetchCoffeeShops() {
        fetchTask?.cancel()
        fetchTask = Task {
            do {
                for try await coffeeShops in persistedCoffeeShopRepository.coffeeShops {
                    _visitedCoffeeShops = coffeeShops.map(PersistedVisitedCoffeeShop.init)
                }
            } catch {
                _visitedCoffeeShops = []
            }
        }
    }
}
