import DetailsFeatureDomain
import MapKit

public struct MapKitLookAroundSceneLoader: LookAroundSceneLoading {
    public init() {}

    public func lookAroundScene(atLatitude latitude: Double, longitude: Double) async throws -> MKLookAroundScene? {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let request = MKLookAroundSceneRequest(coordinate: coordinate)
        return try await request.scene
    }
}
