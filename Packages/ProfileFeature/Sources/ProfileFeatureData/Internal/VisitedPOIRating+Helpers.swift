import DB
import ProfileFeatureDomain

extension VisitedPOIRating {
    init(_ rating: DBRating) {
        switch rating {
        case .unavailable:
            self = .unavailable
        case .one:
            self = .one
        case .two:
            self = .two
        case .three:
            self = .three
        case .four:
            self = .four
        case .five:
            self = .five
        }
    }
}
