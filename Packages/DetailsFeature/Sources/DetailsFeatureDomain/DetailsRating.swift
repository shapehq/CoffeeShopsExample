public enum DetailsRating: Int, Comparable {
    case unavailable = -1
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5

    public static func < (lhs: DetailsRating, rhs: DetailsRating) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
