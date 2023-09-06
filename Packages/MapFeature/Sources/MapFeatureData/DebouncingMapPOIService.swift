import MapFeatureDomain

public final actor DebouncingMapPOIService: MapPOIService {
    private let service: MapPOIService

    public init(decorating service: MapPOIService) {
        self.service = service
    }

    public func pointsOfInterest(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[MapPOI], Error> {
        try await Task.sleep(for: .seconds(0.5))
        return try await service.pointsOfInterest(
            centerLatitude: centerLatitude,
            centerLongitude: centerLongitude,
            latitudeDelta: latitudeDelta,
            longitudeDelta: longitudeDelta
        )
    }
}
