import MapFeatureDomain

public final actor DebouncingCoffeeShopMarkerService: CoffeeShopMarkerService {
    private let service: CoffeeShopMarkerService

    public init(decorating service: CoffeeShopMarkerService) {
        self.service = service
    }

    public func coffeeShops(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[CoffeeShopMarker], Error> {
        try await Task.sleep(for: .seconds(0.5))
        return try await service.coffeeShops(
            centerLatitude: centerLatitude,
            centerLongitude: centerLongitude,
            latitudeDelta: latitudeDelta,
            longitudeDelta: longitudeDelta
        )
    }
}
