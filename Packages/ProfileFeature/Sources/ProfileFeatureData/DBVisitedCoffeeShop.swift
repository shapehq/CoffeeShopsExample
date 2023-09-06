import DB
import ProfileFeatureDomain

public struct DBVisitedCoffeeShop<DBPOIType: DBPOI>: VisitedCofeeShop {
    public let id: DBPOIID
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let rating: VisitedCoffeeShopRating
    public let note: String?

    let dbPOI: DBPOIType

    init(_ dbPOI: DBPOIType) {
        self.dbPOI = dbPOI
        self.id = dbPOI.id
        self.title = dbPOI.title
        self.latitude = dbPOI.latitude
        self.longitude = dbPOI.longitude
        self.rating = VisitedCoffeeShopRating(dbPOI.rating)
        self.note = dbPOI.note
    }
}
