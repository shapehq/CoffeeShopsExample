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
        let visitedCoffeeShopRepository = self.visitedCoffeeShopRepository
        return MapView(
            markerService: DebouncingCoffeeShopMarkerService(
                decorating: CachingCoffeeShopMarkerService(
                    decorating: PersistenceAnnotatingCoffeeShopMarkerService(
                        decorating: MapKitCoffeeShopMarkerService(),
                        persistedCoffeeShopRepository: visitedCoffeeShopRepository
                    )
                )
            )
        ) { marker in
            AppDetailsView(
                marker: marker,
                detailsService: PersistedDetailsService(
                    persistedCoffeeShopRepository: visitedCoffeeShopRepository
                )
            )
        }
    }

    private var profileView: some View {
        ProfileView(
            authenticator: authenticator,
            visitedCoffeeShopRepository: PersistedVisitedCoffeeShopRepository(
                persistedCoffeeShopRepository: visitedCoffeeShopRepository
            )
        )
    }
}

private extension CoffeeShopsApp {
    private var authenticator: some Authenticating {
        Authenticator(credentialsStore: credentialsStore)
    }

    private var visitedCoffeeShopRepository: some PersistedCoffeeShopRepository {
        SwiftDataCoffeeShopRepository(
            modelContext: ModelContext(db.modelContainer)
        )
    }
}
