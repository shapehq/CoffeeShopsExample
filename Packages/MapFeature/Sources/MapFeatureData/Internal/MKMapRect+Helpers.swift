import MapKit

extension MKMapRect {
    func scaled(by scale: CGFloat) -> MKMapRect {
        let origin = MKMapPoint(
            x: origin.x - (size.width * scale - size.width) / 2,
            y: origin.y - (size.height * scale - size.height) / 2
        )
        let size = MKMapSize(width: size.width * scale, height: size.height * scale)
        return  MKMapRect(origin: origin, size: size)
    }
}
