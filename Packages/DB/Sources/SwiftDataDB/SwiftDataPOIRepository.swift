import AnyAsync
import DB
import Foundation
import SwiftData

public final class SwiftDataPOIRepository: DBPOIRepository {
    public private(set) lazy var pointsOfInterest: AnyAsyncSequence<[SwiftDataPOI]> = AnyAsyncSequence(
        SwiftDataAsyncModelSequence<SwiftDataPOI>(modelContext: modelContext)
    )

    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func pointOfInterest(withID id: DBPOIID) throws -> SwiftDataPOI? {
        let fetchDescriptor = FetchDescriptor<SwiftDataPOI>(
            predicate: #Predicate { $0.id.rawValue == id.rawValue }
        )
        let objects = try modelContext.fetch(fetchDescriptor)
        return objects.first
    }

    public func pointsOfInterest(withIDs ids: Set<DBPOIID>) throws -> AnyAsyncSequence<[DBPOIID: DBPOIType]> {
        let rawValueIDs = ids.map(\.rawValue)
        return AnyAsyncSequence(
            SwiftDataAsyncModelSequence<SwiftDataPOI>(
                modelContext: modelContext,
                predicate: #Predicate { rawValueIDs.contains($0.id.rawValue) }
            )
            .map { objects in
                Dictionary(grouping: objects, by: \.id).compactMapValues(\.first)
            }
        )
    }

    public func addPointOfInterest(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String?,
        websiteURL: URL?
    ) -> SwiftDataPOI {
        let poi = SwiftDataPOI(
            title: title,
            latitude: latitude,
            longitude: longitude,
            websiteURL: websiteURL,
            phoneNumber: phoneNumber,
            rating: .unavailable,
            note: nil
        )
        modelContext.insert(poi)
        return poi
    }

    public func deletePointOfInterest(_ poi: SwiftDataPOI) {
        modelContext.delete(poi)
    }
}
