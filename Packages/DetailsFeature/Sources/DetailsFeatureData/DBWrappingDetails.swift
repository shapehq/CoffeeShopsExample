import DB
import DetailsFeatureDomain
import Foundation

@Observable
final class DBWrappingDetails<DBPOIRepositoryType: DBPOIRepository>: Details {
    let title: String
    let latitude: Double
    let longitude: Double
    let phoneNumber: String?
    let websiteURL: URL?
    var rating: DetailsRating {
        didSet {
            if rating != oldValue {
                dbPOI.rating = DBRating(rating)
            }
        }
    }
    var note: String? {
        didSet {
            if note != oldValue {
                dbPOI.note = note
            }
        }
    }

    private let dbPOIRepository: DBPOIRepositoryType
    private var cachedDBPOI: DBPOI?
    private var dbPOI: DBPOI {
        if let cachedDBPOI {
            return cachedDBPOI
        } else {
            let dbPOI = dbPOIRepository.addPointOfInterest(
                title: title,
                latitude: latitude,
                longitude: longitude,
                phoneNumber: phoneNumber,
                websiteURL: websiteURL
            )
            cachedDBPOI = dbPOI
            return dbPOI
        }
    }

    convenience init(
        _ sparseDetails: SparseDetails,
        dbPOI: DBPOI,
        dbPOIRepository: DBPOIRepositoryType
    ) {
        self.init(sparseDetails, dbPOIRepository: dbPOIRepository)
        cachedDBPOI = dbPOI
        rating = DetailsRating(dbPOI.rating)
        note = dbPOI.note
    }

    init(_ sparseDetails: SparseDetails, dbPOIRepository: DBPOIRepositoryType) {
        self.dbPOIRepository = dbPOIRepository
        self.title = sparseDetails.title
        self.latitude = sparseDetails.latitude
        self.longitude = sparseDetails.longitude
        self.phoneNumber = sparseDetails.phoneNumber
        self.websiteURL = sparseDetails.websiteURL
        self.rating = .unavailable
        self.note = nil
    }
}
