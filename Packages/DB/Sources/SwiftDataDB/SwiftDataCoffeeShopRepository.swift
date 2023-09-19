import AnyAsync
import DB
import Foundation
import SwiftData

public final class SwiftDataCoffeeShopRepository: PersistedCoffeeShopRepository {
    public private(set) lazy var coffeeShops: AnyAsyncSequence<[SwiftDataCoffeeShop]> = AnyAsyncSequence(
        SwiftDataAsyncModelSequence<SwiftDataCoffeeShop>(modelContext: modelContext)
    )

    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func coffeeShop(withID id: PersistedCoffeeShopID) throws -> SwiftDataCoffeeShop? {
        let fetchDescriptor = FetchDescriptor<SwiftDataCoffeeShop>(
            predicate: #Predicate { $0.id.rawValue == id.rawValue }
        )
        let objects = try modelContext.fetch(fetchDescriptor)
        return objects.first
    }

    public func coffeeShops(withIDs ids: Set<PersistedCoffeeShopID>) throws -> AnyAsyncSequence<[PersistedCoffeeShopID: PersistedCoffeeShopType]> {
        let rawValueIDs = ids.map(\.rawValue)
        return AnyAsyncSequence(
            SwiftDataAsyncModelSequence<SwiftDataCoffeeShop>(
                modelContext: modelContext,
                predicate: #Predicate { rawValueIDs.contains($0.id.rawValue) }
            )
            .map { objects in
                Dictionary(grouping: objects, by: \.id).compactMapValues(\.first)
            }
        )
    }

    public func addCoffeeShop(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String?,
        websiteURL: URL?
    ) -> SwiftDataCoffeeShop {
        let coffeeShop = SwiftDataCoffeeShop(
            title: title,
            latitude: latitude,
            longitude: longitude,
            websiteURL: websiteURL,
            phoneNumber: phoneNumber,
            rating: .unavailable,
            note: nil
        )
        modelContext.insert(coffeeShop)
        return coffeeShop
    }

    public func deleteCoffeeShop(_ coffeeShop: SwiftDataCoffeeShop) {
        modelContext.delete(coffeeShop)
    }
}
