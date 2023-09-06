import DetailsFeatureDomain
import MapKit

struct NullObjectLookAroundSceneLoader: LookAroundSceneLoading {
    func lookAroundScene(
        atLatitude latitude: Double,
        longitude: Double
    ) async throws -> MKLookAroundScene? {
        nil
    }
}
