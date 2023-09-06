import AnyAsync
import DB
import Observation
import ProfileFeatureDomain

@Observable
public final class DBVisitedCoffeShopsRepository<DBPOIRepositoryType: DBPOIRepository>: VisitedCoffeeShopsRepository {
    public var visitedCoffeeShops: [DBVisitedCoffeeShop<DBPOIRepositoryType.DBPOIType>] {
        if fetchTask == nil {
            fetchCoffeeShops()
        }
        return _visitedCoffeeShops
    }

    private var _visitedCoffeeShops: [DBVisitedCoffeeShop<DBPOIRepositoryType.DBPOIType>] = []

    private let dbPOIRepository: DBPOIRepositoryType
    private var fetchTask: Task<Void, Never>?

    public init(dbPOIRepository: DBPOIRepositoryType) {
        self.dbPOIRepository = dbPOIRepository
    }

    public func deleteVisitedCoffeeShop(_ coffeeShop: DBVisitedCoffeeShop<DBPOIRepositoryType.DBPOIType>) {
        dbPOIRepository.deletePointOfInterest(coffeeShop.dbPOI)
    }
}

private extension DBVisitedCoffeShopsRepository {
    private func fetchCoffeeShops() {
        fetchTask?.cancel()
        fetchTask = Task {
            do {
                for try await pointsOfInterest in dbPOIRepository.pointsOfInterest {
                    _visitedCoffeeShops = pointsOfInterest.map(DBVisitedCoffeeShop.init)
                }
            } catch {
                _visitedCoffeeShops = []
            }
        }
    }
}
