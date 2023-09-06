import MapKit
import MapFeatureDomain

extension MapPOI {
    init?(_ mapItem: MKMapItem) {
        guard let name = mapItem.name else {
            return nil
        }
        self.init(
            title: name, 
            latitude: mapItem.placemark.coordinate.latitude,
            longitude: mapItem.placemark.coordinate.longitude,
            phoneNumber: mapItem.phoneNumber,
            websiteURL: mapItem.url,
            color: .black
        )
    }

    func withColor(_ color: MapPOI.Color) -> MapPOI {
        MapPOI(
            title: title,
            latitude: latitude,
            longitude: longitude,
            phoneNumber: phoneNumber,
            websiteURL: websiteURL,
            color: color
        )
    }
}
