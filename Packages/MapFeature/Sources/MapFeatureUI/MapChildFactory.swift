import MapFeatureDomain
import SwiftUI

public protocol MapChildViewFactory {
    associatedtype DetailsChildViewType: View
    func makeDetailsView(showing pointOfInterest: MapPOI) -> DetailsChildViewType
}
