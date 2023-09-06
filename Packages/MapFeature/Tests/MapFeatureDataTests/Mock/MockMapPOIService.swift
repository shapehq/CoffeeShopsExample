import MapFeatureDomain

final class MockMapPOIService: MapPOIService {
    private let pointsOfInterest: [MapPOI]

    private(set) var numberOfInvocations = 0

    init(pointsOfInterest: [MapPOI]) {
        self.pointsOfInterest = pointsOfInterest
    }

    func pointsOfInterest(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[MapPOI], Error> {
        numberOfInvocations += 1
        return AsyncThrowingStream { continuation in
            continuation.yield(pointsOfInterest)
            continuation.finish()
        }
    }
}
