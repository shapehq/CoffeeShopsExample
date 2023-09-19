import DB
import MapFeatureDomain
import MapKit

public final class MapKitCoffeeShopMarkerService: CoffeeShopMarkerService {
    public init() {}

    public func coffeeShops(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[CoffeeShopMarker], Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                let region = MKCoordinateRegion(
                    centerLatitude: centerLatitude,
                    centerLongitude: centerLongitude,
                    latitudeDelta: latitudeDelta,
                    longitudeDelta: longitudeDelta
                )
                guard !Task.isCancelled else {
                    return
                }
                let mapItems = try await self.search(for: "coffee", in: region)
                let mapCoffeeShops = mapItems.compactMap(CoffeeShopMarker.init)
                continuation.yield(mapCoffeeShops)
                continuation.finish()
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}

private extension MapKitCoffeeShopMarkerService {
    private func search(for query: String, in region: MKCoordinateRegion) async throws -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "coffee"
        request.region = region
        request.resultTypes = .pointOfInterest
        let localSearch = MKLocalSearch(request: request)
        let response = try await localSearch.start()
        return response.mapItems
    }
}
