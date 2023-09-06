import ProfileFeatureDomain

struct PreviewVisitedCoffeeShop: VisitedCofeeShop, Equatable {
    var id: String {
        title
    }
    let title: String
    let latitude: Double
    let longitude: Double
    let rating: VisitedCoffeeShopRating
    let note: String?
}
