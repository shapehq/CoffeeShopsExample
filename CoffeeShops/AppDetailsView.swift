import DetailsFeatureDomain
import DetailsFeatureUI
import MapFeatureDomain
import MapFeatureUI
import MapsAppOpenerDomain
import SwiftUI

struct AppDetailsView<DetailsServiceType: DetailsService>: View {
    let marker: CoffeeShopMarker
    let detailsService: DetailsServiceType
    let mapsAppOpener: MapsAppOpening

    var body: some View {
        DetailsView(
            SparseDetails(
                title: marker.title,
                latitude: marker.latitude,
                longitude: marker.longitude,
                phoneNumber: marker.phoneNumber,
                websiteURL: marker.websiteURL
            ),
            detailsService: detailsService,
            mapsAppOpener: mapsAppOpener
        )
    }
}
