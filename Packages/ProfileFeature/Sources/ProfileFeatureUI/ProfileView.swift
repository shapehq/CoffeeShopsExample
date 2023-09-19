import AuthenticationDomain
import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

public struct ProfileView<VisitedCoffeeShopRepositoryType: VisitedCoffeeShopRepository>: View {
    private let authenticator: Authenticating
    private let visitedCoffeeShopRepository: VisitedCoffeeShopRepositoryType
    private let mapsAppOpener: MapsAppOpening
    @State private var isConfirmLogOutPresented = false
    private var visitedCoffeeShopsDetail: String? {
        let visitedCoffeeShops = visitedCoffeeShopRepository.visitedCoffeeShops
        if !visitedCoffeeShops.isEmpty {
            return "\(visitedCoffeeShops.count)"
        } else {
            return nil
        }
    }

    public init(
        authenticator: Authenticating,
        visitedCoffeeShopRepository: VisitedCoffeeShopRepositoryType,
        mapsAppOpener: MapsAppOpening
    ) {
        self.authenticator = authenticator
        self.visitedCoffeeShopRepository = visitedCoffeeShopRepository
        self.mapsAppOpener = mapsAppOpener
    }

    public var body: some View {
        NavigationView {
            List {
                Section {
                    ProfileHeaderView(
                        name: "Simon B. Støvring",
                        membership: "Premium Member"
                    )
                }
                Section {
                    NavigationLink {
                        VisitedCoffeeShopsView(
                            visitedCoffeeShopRepository: visitedCoffeeShopRepository,
                            mapsAppOpener: mapsAppOpener
                        )
                    } label: {
                        TitleDetailRow(
                            title: "Visited Coffee Shops",
                            detail: visitedCoffeeShopsDetail
                        )
                    }
                }
                Section {
                    Button {
                        isConfirmLogOutPresented = true
                    } label: {
                        Text("Log Out")
                    }
                }
            }
            .navigationTitle("Profile")
            .confirmationDialog("Log Out", isPresented: $isConfirmLogOutPresented) {
                Button(role: .destructive) {
                    authenticator.signOut()
                } label: {
                    Text("Yes, log out")
                }
                Button(role: .cancel) {

                } label: {
                    Text("Cancel")
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
        }
        .tabItem {
            Image(systemName: "person")
            Text("Profile")
        }
    }
}

#Preview {
    ProfileView(
        authenticator: PreviewAuthenticator(),
        visitedCoffeeShopRepository: PreviewVisitedCoffeeShopRepository(),
        mapsAppOpener: PreviewMapsAppOpener()
    )
}
