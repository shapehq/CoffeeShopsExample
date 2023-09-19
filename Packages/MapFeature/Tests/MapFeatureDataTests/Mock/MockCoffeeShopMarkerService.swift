import MapFeatureDomain

final class MockCoffeeShopMarkerService: CoffeeShopMarkerService {
    private let coffeeShops: [CoffeeShopMarker]

    private(set) var numberOfInvocations = 0

    init(coffeeShops: [CoffeeShopMarker]) {
        self.coffeeShops = coffeeShops
    }

    func coffeeShops(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[CoffeeShopMarker], Error> {
        numberOfInvocations += 1
        return AsyncThrowingStream { continuation in
            continuation.yield(coffeeShops)
            continuation.finish()
        }
    }
}
