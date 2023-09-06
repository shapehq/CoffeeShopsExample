import MapKit
import MapsLauncherDomain

public struct MapKitMapsLauncher: MapsLaunching {
    public init() {}

    public func openMaps(showingLatitude latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        MKMapItem.openMaps(with: [mapItem], launchOptions: [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: coordinate),
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
        ])
    }
}
