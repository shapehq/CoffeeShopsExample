import MapFeatureDomain
import MapKit

public final class CachingMapPOIService: MapPOIService {
    private let service: MapPOIService
    private var cache: [MapPOI] = []

    public init(decorating service: MapPOIService) {
        self.service = service
    }

    public func pointsOfInterest(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[MapPOI], Error> {
        AsyncThrowingStream { continuation in
            let task = Task { [weak self] in
                guard let self else {
                    return
                }
                let stream = try await self.service.pointsOfInterest(
                    centerLatitude: centerLatitude,
                    centerLongitude: centerLongitude,
                    latitudeDelta: latitudeDelta,
                    longitudeDelta: longitudeDelta
                )
                for try await pointsOfInterest in stream {
                    let newPOIIDs = pointsOfInterest.map(\.id)
                    self.cache.removeAll { newPOIIDs.contains($0.id) }
                    self.cache.append(contentsOf: pointsOfInterest)
                    // Increase the region passed to the cache to ensure we have items visible when the user pans a little.
                    let regionCenter = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
                    let regionSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta * 2, longitudeDelta: longitudeDelta * 2)
                    let region = MKCoordinateRegion(center: regionCenter, span: regionSpan)
                    let result = self.cache.pointsOfInterest(within: region)
                    continuation.yield(result)
                }
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}

private extension Collection where Element == MapPOI {
    func pointsOfInterest(within region: MKCoordinateRegion) -> [Element] {
        return filter { pointOfInterest in
            let coordinate = CLLocationCoordinate2D(
                latitude: pointOfInterest.latitude,
                longitude: pointOfInterest.longitude
            )
            return region.contains(coordinate)
        }
    }
}
