import DB
import MapFeatureDomain
import MapKit

public final class PersistenceAnnotatingCoffeeShopMarkerService<
    PersistedCoffeeShopRepositoryType: PersistedCoffeeShopRepository
>: CoffeeShopMarkerService {
    private let service: CoffeeShopMarkerService
    private let persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType

    public init(
        decorating service: CoffeeShopMarkerService,
        persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType
    ) {
        self.service = service
        self.persistedCoffeeShopRepository = persistedCoffeeShopRepository
    }

    public func coffeeShops(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[CoffeeShopMarker], Error> {
        AsyncThrowingStream { continuation in
            let task = Task { [weak self] in
                guard let self else {
                    return
                }
                let coffeeShopsStream = try await self.service.coffeeShops(
                    centerLatitude: centerLatitude,
                    centerLongitude: centerLongitude,
                    latitudeDelta: latitudeDelta,
                    longitudeDelta: longitudeDelta
                )
                .flatMap { coffeeShops in
                    let persistedCoffeeShopIDs = Set(coffeeShops.map { PersistedCoffeeShopID(latitude: $0.latitude, longitude: $0.longitude) })
                    return try self.persistedCoffeeShopRepository.coffeeShops(withIDs: persistedCoffeeShopIDs).map { persistedCoffeeShops in
                        return coffeeShops.map { coffeeShop in
                            let persistedCoffeeShopID = PersistedCoffeeShopID(latitude: coffeeShop.latitude, longitude: coffeeShop.longitude)
                            guard let persistedCoffeeShop = persistedCoffeeShops[persistedCoffeeShopID] else {
                                return coffeeShop
                            }
                            let color = CoffeeShopMarker.Color(persistedCoffeeShop.rating)
                            return coffeeShop.withColor(color)
                        }
                    }
                }
                for try await coffeeShops in coffeeShopsStream {
                    continuation.yield(coffeeShops)
                }
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}
