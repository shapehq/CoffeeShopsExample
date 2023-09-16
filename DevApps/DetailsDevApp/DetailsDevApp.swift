import DetailsFeatureDomain
import DetailsFeatureUI
import MapsLauncherData
import SwiftUI

@main
struct DetailsDevApp: App {
    var body: some Scene {
        WindowGroup {
            DetailsView(
                SparseDetails(
                    title: "Prufrock Coffee",
                    latitude: 51.519922,
                    longitude: -0.109431,
                    phoneNumber: "+44 20 7242 0467",
                    websiteURL: URL(string: "https://prufrockcoffee.com")
                ),
                detailsService: MockDetailsService(),
                mapsLauncher: MapKitMapsLauncher()
            )
        }
    }
}
