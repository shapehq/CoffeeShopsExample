import MapFeatureDomain
import SwiftUI

struct PreviewMapChildViewFactory: MapChildViewFactory {
    func makeDetailsView(showing marker: MapPOI) -> some View {
        Text("POI Details")
            .background(.background)
    }
}
