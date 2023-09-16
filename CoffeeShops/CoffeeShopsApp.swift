import AuthenticationData
import AuthenticationDomain
import DB
import DetailsFeatureData
import DetailsFeatureDomain
import DetailsFeatureUI
import MapFeatureData
import MapFeatureDomain
import MapFeatureUI
import MapsAppOpenerData
import MapsAppOpenerDomain
import OnboardingFeatureUI
import ProfileFeatureData
import ProfileFeatureUI
import SwiftData
import SwiftDataDB
import SwiftUI

@main
struct CoffeeShopsApp: App {
    private let credentialsStore: CredentialsStoring = UserDefaultsCredentialsStore(userDefaults: .standard)
    private let db = SwiftDataDB(isStoredInMemoryOnly: false)

    var body: some Scene {
        WindowGroup {
            OnboardingView(authenticator: authenticator) {
                TabView {
                    mapView
                    profileView
                }
            }
        }
    }
}

private extension CoffeeShopsApp {
    private var mapView: some View {
        let dbPOIRepository = self.dbPOIRepository
        return MapView(
            mapPOIService: DebouncingMapPOIService(
                decorating: CachingMapPOIService(
                    decorating: DBMapPOIService(
                        decorating: MapKitMapPOIService(),
                        dbPOIRepository: dbPOIRepository
                    )
                )
            )
        ) { poi in
            AppDetailsView(
                poi: poi,
                detailsService: DBDetailsService(
                    dbPOIRepository: dbPOIRepository
                ),
                mapsAppOpener: mapsAppOpener
            )
        }
    }

    private var profileView: some View {
        ProfileView(
            authenticator: authenticator,
            visitedPOIsRepository: DBVisitedPOIsRepository(
                dbPOIRepository: dbPOIRepository
            ),
            mapsAppOpener: mapsAppOpener
        )
    }
}

private extension CoffeeShopsApp {
    private var mapsAppOpener: some MapsAppOpening {
        MapKitMapsAppOpener()
    }

    private var authenticator: some Authenticating {
        Authenticator(credentialsStore: credentialsStore)
    }

    private var dbPOIRepository: some DBPOIRepository {
        SwiftDataPOIRepository(
            modelContext: ModelContext(db.modelContainer)
        )
    }
}
