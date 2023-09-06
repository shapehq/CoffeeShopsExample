import MapKit

public protocol LookAroundSceneLoading {
    func lookAroundScene(
        atLatitude latitude: Double,
        longitude: Double
    ) async throws -> MKLookAroundScene?
}
