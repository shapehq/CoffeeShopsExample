import MapKit
import DetailsFeatureDomain

struct NullObjectLookAroundSceneLoader: LookAroundSceneLoading {
    func lookAroundScene(
        atLatitude latitude: Double,
        longitude: Double
    ) async throws -> MKLookAroundScene? {
        nil
    }
}
