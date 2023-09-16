import DetailsFeatureDomain
import DetailsFeatureUI
import MapFeatureDomain
import MapFeatureUI
import MapsLauncherDomain
import SwiftUI

struct AppDetailsView<DetailsServiceType: DetailsService>: View {
    let poi: MapPOI
    let detailsService: DetailsServiceType
    let lookAroundSceneLoader: LookAroundSceneLoading
    let mapsLauncher: MapsLaunching

    var body: some View {
        return DetailsView(
            SparseDetails(
                title: poi.title,
                latitude: poi.latitude,
                longitude: poi.longitude,
                phoneNumber: poi.phoneNumber,
                websiteURL: poi.websiteURL
            ),
            detailsService: detailsService,
            lookAroundSceneLoader: lookAroundSceneLoader,
            mapsLauncher: mapsLauncher
        )
    }
}
