import AuthenticationDomain
import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

public struct ProfileView<VisitedPOIRepositoryType: VisitedPOIRepository>: View {
    private let authenticator: Authenticating
    private let visitedPOIRepository: VisitedPOIRepositoryType
    private let mapsAppOpener: MapsAppOpening
    @State private var isConfirmLogOutPresented = false
    private var visitedPOIsDetail: String? {
        let visitedPOIs = visitedPOIRepository.visitedPOIs
        if !visitedPOIs.isEmpty {
            return "\(visitedPOIs.count)"
        } else {
            return nil
        }
    }

    public init(
        authenticator: Authenticating,
        visitedPOIRepository: VisitedPOIRepositoryType,
        mapsAppOpener: MapsAppOpening
    ) {
        self.authenticator = authenticator
        self.visitedPOIRepository = visitedPOIRepository
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
                        VisitedPOIsView(
                            visitedPOIRepository: visitedPOIRepository,
                            mapsAppOpener: mapsAppOpener
                        )
                    } label: {
                        TitleDetailRow(
                            title: "Visited Coffee Shops",
                            detail: visitedPOIsDetail
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
        visitedPOIRepository: PreviewVisitedPOIRepository(),
        mapsAppOpener: PreviewMapsAppOpener()
    )
}
