import Foundation
import SwiftData

final class SwiftDataAsyncModelSequence<ModelType: PersistentModel>: AsyncSequence {
    typealias Element = [ModelType]

    private let modelContext: ModelContext
    private let predicate: Predicate<ModelType>?
    private let sortDescriptors: [SortDescriptor<ModelType>]

    init(
        modelContext: ModelContext,
        predicate: Predicate<ModelType>? = nil,
        sortDescriptors: [SortDescriptor<ModelType>] = []
    ) {
        self.modelContext = modelContext
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
    }

    func makeAsyncIterator() -> SwiftDataAsyncModelIterator<ModelType> {
        SwiftDataAsyncModelIterator(
            modelContext: modelContext,
            predicate: predicate,
            sortDescriptors: sortDescriptors
        )
    }
}
