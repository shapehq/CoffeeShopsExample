import DetailsFeatureDomain
import MapKit

struct PreviewLookAroundSceneLoader: LookAroundSceneLoading {
    func lookAroundScene(
        atLatitude latitude: Double,
        longitude: Double
    ) async throws -> MKLookAroundScene? {
        nil
    }
}
