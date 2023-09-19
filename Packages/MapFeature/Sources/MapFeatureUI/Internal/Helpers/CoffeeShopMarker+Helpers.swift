import CoreLocation
import MapFeatureDomain
import SwiftUI

extension CoffeeShopMarker {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
