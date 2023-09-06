import MapKit
import DetailsFeatureDomain

struct PreviewLookAroundSceneLoader: LookAroundSceneLoading {
    func lookAroundScene(
        atLatitude latitude: Double,
        longitude: Double
    ) async throws -> MKLookAroundScene? {
        nil
    }
}
