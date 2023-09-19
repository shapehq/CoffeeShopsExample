import DB
import DetailsFeatureDomain
import Foundation

@Observable
final class PersistedDetails<PersistedCoffeeShopRepositoryType: PersistedCoffeeShopRepository>: Details {
    let title: String
    let latitude: Double
    let longitude: Double
    let phoneNumber: String?
    let websiteURL: URL?
    var rating: DetailsRating {
        didSet {
            if rating != oldValue {
                persistedCoffeeShop.rating = PersistedRating(rating)
            }
        }
    }
    var note: String? {
        didSet {
            if note != oldValue {
                persistedCoffeeShop.note = note
            }
        }
    }

    private let persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType
    private var cachedPersistedCoffeeShop: PersistedCoffeeShop?
    private var persistedCoffeeShop: PersistedCoffeeShop {
        if let cachedPersistedCoffeeShop {
            return cachedPersistedCoffeeShop
        } else {
            let persistedCoffeeShop = persistedCoffeeShopRepository.addCoffeeShop(
                title: title,
                latitude: latitude,
                longitude: longitude,
                phoneNumber: phoneNumber,
                websiteURL: websiteURL
            )
            cachedPersistedCoffeeShop = persistedCoffeeShop
            return persistedCoffeeShop
        }
    }

    convenience init(
        _ sparseDetails: SparseDetails,
        persistedCoffeeShop: PersistedCoffeeShop,
        persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType
    ) {
        self.init(sparseDetails, persistedCoffeeShopRepository: persistedCoffeeShopRepository)
        cachedPersistedCoffeeShop = persistedCoffeeShop
        rating = DetailsRating(persistedCoffeeShop.rating)
        note = persistedCoffeeShop.note
    }

    init(_ sparseDetails: SparseDetails, persistedCoffeeShopRepository: PersistedCoffeeShopRepositoryType) {
        self.persistedCoffeeShopRepository = persistedCoffeeShopRepository
        self.title = sparseDetails.title
        self.latitude = sparseDetails.latitude
        self.longitude = sparseDetails.longitude
        self.phoneNumber = sparseDetails.phoneNumber
        self.websiteURL = sparseDetails.websiteURL
        self.rating = .unavailable
        self.note = nil
    }
}
