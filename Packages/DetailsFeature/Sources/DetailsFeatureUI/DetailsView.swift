import DetailsFeatureDomain
import MapKit
import SwiftUI

public struct DetailsView<DetailsServiceType: DetailsService>: View {
    private let sparseDetails: SparseDetails
    private let detailsService: DetailsServiceType
    @State private var details: DetailsServiceType.DetailsType?

    public init(_ sparseDetails: SparseDetails, detailsService: DetailsServiceType) {
        self.sparseDetails = sparseDetails
        self.detailsService = detailsService
    }

    public var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                HeaderView(title: sparseDetails.title) { }
                AsyncLookAroundPreview {
                    try await loadLookAroundScene()
                }
                ContactInformationView(
                    phoneNumber: sparseDetails.phoneNumber,
                    websiteURL: sparseDetails.websiteURL
                )
                if let details {
                    InnerDetailsView(details: details)
                }
            }
        }
        .onChange(of: sparseDetails) { _, _ in
            Task {
                await loadDetails()
            }
        }
        .task {
            await loadDetails()
        }
    }
}

private extension DetailsView {
    private func loadLookAroundScene() async throws -> MKLookAroundScene? {
        let coordinate = CLLocationCoordinate2D(
            latitude: sparseDetails.latitude,
            longitude: sparseDetails.longitude
        )
        let request = MKLookAroundSceneRequest(coordinate: coordinate)
        return try await request.scene
    }

    private func loadDetails() async {
        do {
            details = try await detailsService.coffeeShopDetails(for: sparseDetails)
        } catch {}
    }
}

#Preview {
    DetailsView(
        SparseDetails(
            title: "Prufrock Coffee",
            latitude: 51.519922,
            longitude: -0.109431,
            phoneNumber: "+44 20 7242 0467",
            websiteURL: URL(string: "https://prufrockcoffee.com")
        ),
        detailsService: PreviewDetailsService()
    )
}
