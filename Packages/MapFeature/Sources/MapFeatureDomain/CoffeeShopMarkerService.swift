import Foundation

public protocol CoffeeShopMarkerService {
    func coffeeShops(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[CoffeeShopMarker], Error>
}
