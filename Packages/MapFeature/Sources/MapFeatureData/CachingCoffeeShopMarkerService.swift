import MapFeatureDomain
import MapKit

public final class CachingCoffeeShopMarkerService: CoffeeShopMarkerService {
    private let service: CoffeeShopMarkerService
    private var cache: [CoffeeShopMarker] = []

    public init(decorating service: CoffeeShopMarkerService) {
        self.service = service
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
                let stream = try await self.service.coffeeShops(
                    centerLatitude: centerLatitude,
                    centerLongitude: centerLongitude,
                    latitudeDelta: latitudeDelta,
                    longitudeDelta: longitudeDelta
                )
                for try await coffeeShops in stream {
                    let newCoffeeShopIDs = coffeeShops.map(\.id)
                    self.cache.removeAll { newCoffeeShopIDs.contains($0.id) }
                    self.cache.append(contentsOf: coffeeShops)
                    // Increase the region passed to the cache to ensure we have items visible when the user pans a little.
                    let regionCenter = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
                    let regionSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta * 2, longitudeDelta: longitudeDelta * 2)
                    let region = MKCoordinateRegion(center: regionCenter, span: regionSpan)
                    let result = self.cache.coffeeShops(within: region)
                    continuation.yield(result)
                }
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}

private extension Collection where Element == CoffeeShopMarker {
    func coffeeShops(within region: MKCoordinateRegion) -> [Element] {
        return filter { coffeeShop in
            let coordinate = CLLocationCoordinate2D(
                latitude: coffeeShop.latitude,
                longitude: coffeeShop.longitude
            )
            return region.contains(coordinate)
        }
    }
}
