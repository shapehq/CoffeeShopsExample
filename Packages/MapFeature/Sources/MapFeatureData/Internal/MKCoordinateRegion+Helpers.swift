import MapKit

extension MKCoordinateRegion {
    init(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) {
        let centerCoordinate = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let regionSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        self.init(center: centerCoordinate, span: regionSpan)
    }

    func contains(_ coordinate: CLLocationCoordinate2D) -> Bool {
        cos((center.latitude - coordinate.latitude) * .pi / 180) > cos(span.latitudeDelta / 2 * .pi / 180) &&
        cos((center.longitude - coordinate.longitude) * .pi / 180) > cos(span.longitudeDelta / 2 * .pi / 180)
    }
}
