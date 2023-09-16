import DetailsFeatureDomain
import DetailsFeatureUI
import MapFeatureDomain
import MapFeatureUI
import MapsAppOpenerDomain
import SwiftUI

struct AppDetailsView<DetailsServiceType: DetailsService>: View {
    let poi: MapPOI
    let detailsService: DetailsServiceType
    let mapsAppOpener: MapsAppOpening

    var body: some View {
        DetailsView(
            SparseDetails(
                title: poi.title,
                latitude: poi.latitude,
                longitude: poi.longitude,
                phoneNumber: poi.phoneNumber,
                websiteURL: poi.websiteURL
            ),
            detailsService: detailsService,
            mapsAppOpener: mapsAppOpener
        )
    }
}
