import MapFeatureDomain
import MapFeatureUI
import SwiftUI

struct MapDevAppChildViewFactory: MapChildViewFactory {
    func makeDetailsView(showing pointOfInterest: MapPOI) -> some View {
        ZStack(alignment: .topLeading) {
            Color.clear
                .background(.regularMaterial)
                .edgesIgnoringSafeArea(.all)
            Text("Mock Details")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
