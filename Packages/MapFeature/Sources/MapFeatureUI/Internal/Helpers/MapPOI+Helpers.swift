import CoreLocation
import MapFeatureDomain
import SwiftUI

extension MapPOI {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
