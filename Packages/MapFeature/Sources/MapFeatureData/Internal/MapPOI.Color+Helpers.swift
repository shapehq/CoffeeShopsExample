import DB
import MapFeatureDomain

extension MapPOI.Color {
    init(_ rating: DBRating) {
        switch rating {
        case .unavailable:
            self = .black
        case .one:
            self = .red
        case .two:
            self = .orange
        case .three:
            self = .yellow
        case .four:
            self = .green
        case .five:
            self = .blue
        }
    }
}
