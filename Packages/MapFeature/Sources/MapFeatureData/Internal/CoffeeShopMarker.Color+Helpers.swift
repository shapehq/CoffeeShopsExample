import DB
import MapFeatureDomain

extension CoffeeShopMarker.Color {
    init(_ rating: PersistedRating) {
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
