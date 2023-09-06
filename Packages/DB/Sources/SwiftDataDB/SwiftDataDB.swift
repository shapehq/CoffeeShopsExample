import Foundation
import SwiftData

public final class SwiftDataDB {
    public let modelContainer: ModelContainer

    public init(isStoredInMemoryOnly: Bool) {
        modelContainer = try! ModelContainer(
            for: SwiftDataPOI.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: isStoredInMemoryOnly
            )
        )
    }
}
