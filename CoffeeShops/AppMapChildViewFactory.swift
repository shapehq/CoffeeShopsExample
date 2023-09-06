import MapsLauncherDomain
import MapFeatureDomain
import MapFeatureUI
import DetailsFeatureDomain
import DetailsFeatureUI
import SwiftUI

struct AppMapChildViewFactory<DetailsServiceType: DetailsService>: MapChildViewFactory {
    let detailsService: DetailsServiceType
    let lookAroundSceneLoader: LookAroundSceneLoading
    let mapsLauncher: MapsLaunching

    func makeDetailsView(showing marker: MapPOI) -> some View {
        let sparseDetails = SparseDetails(
            title: marker.title,
            latitude: marker.latitude,
            longitude: marker.longitude,
            phoneNumber: marker.phoneNumber,
            websiteURL: marker.websiteURL
        )
        return DetailsView(
            sparseDetails,
            detailsService: detailsService,
            lookAroundSceneLoader: lookAroundSceneLoader,
            mapsLauncher: mapsLauncher
        )
    }
}
