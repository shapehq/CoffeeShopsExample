import AuthenticationDomain
import MapsLauncherDomain
import ProfileFeatureDomain
import SwiftUI

public struct ProfileView<VisitedCoffeeShopsRepositoryType: VisitedCoffeeShopsRepository>: View {
    private let authenticator: Authenticating
    private let visitedCoffeeShopsRepository: VisitedCoffeeShopsRepositoryType
    private let mapsLauncher: MapsLaunching
    @State private var isConfirmLogOutPresented = false
    private var visitedCoffeeShopsDetail: String? {
        let visitedCoffeeShops = visitedCoffeeShopsRepository.visitedCoffeeShops
        if !visitedCoffeeShops.isEmpty {
            return "\(visitedCoffeeShops.count)"
        } else {
            return nil
        }
    }

    public init(
        authenticator: Authenticating,
        visitedCoffeeShopsRepository: VisitedCoffeeShopsRepositoryType,
        mapsLauncher: MapsLaunching
    ) {
        self.authenticator = authenticator
        self.visitedCoffeeShopsRepository = visitedCoffeeShopsRepository
        self.mapsLauncher = mapsLauncher
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
                            visitedCoffeeShopsRepository: visitedCoffeeShopsRepository,
                            mapsLauncher: mapsLauncher
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
        visitedCoffeeShopsRepository: PreviewVisitedCoffeeShopsRepository(),
        mapsLauncher: PreviewMapsLauncher()
    )
}
