import DB
import ProfileFeatureDomain

public struct DBVisitedPOI<DBPOIType: DBPOI>: VisitedPOI {
    public let id: DBPOIID
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let rating: VisitedPOIRating
    public let note: String?

    let dbPOI: DBPOIType

    init(_ dbPOI: DBPOIType) {
        self.dbPOI = dbPOI
        self.id = dbPOI.id
        self.title = dbPOI.title
        self.latitude = dbPOI.latitude
        self.longitude = dbPOI.longitude
        self.rating = VisitedPOIRating(dbPOI.rating)
        self.note = dbPOI.note
    }
}
