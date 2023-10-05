import AuthenticationData
import AuthenticationDomain
import DB
import DetailsFeatureData
import DetailsFeatureDomain
import DetailsFeatureUI
import MapFeatureData
import MapFeatureDomain
import MapFeatureUI
import OnboardingFeatureUI
import ProfileFeatureData
import ProfileFeatureUI
import SwiftData
import SwiftDataDB
import SwiftUI

@main
struct CoffeeShopsApp: App {
    private let credentialsStore: CredentialsStoring = UserDefaultsCredentialsStore(
        userDefaults: .standard
    )
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
        let persistedCoffeeShopRepository = self.persistedCoffeeShopRepository
        return MapView(
            markerService: DebouncingCoffeeShopMarkerService(
                decorating: CachingCoffeeShopMarkerService(
                    decorating: PersistenceAnnotatingCoffeeShopMarkerService(
                        decorating: MapKitCoffeeShopMarkerService(),
                        persistedCoffeeShopRepository: persistedCoffeeShopRepository
                    )
                )
            )
        ) { marker in
            AppDetailsView(
                marker: marker,
                detailsService: PersistedDetailsService(
                    persistedCoffeeShopRepository: persistedCoffeeShopRepository
                )
            )
        }
    }

    private var profileView: some View {
        ProfileView(
            authenticator: authenticator,
            visitedCoffeeShopRepository: PersistedVisitedCoffeeShopRepository(
                persistedCoffeeShopRepository: persistedCoffeeShopRepository
            )
        )
    }
}

private extension CoffeeShopsApp {
    private var authenticator: some Authenticating {
        Authenticator(credentialsStore: credentialsStore)
    }

    private var persistedCoffeeShopRepository: some PersistedCoffeeShopRepository {
        SwiftDataCoffeeShopRepository(
            modelContext: ModelContext(db.modelContainer)
        )
    }
}
