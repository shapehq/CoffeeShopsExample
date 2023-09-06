import CoreData
import Foundation
import SwiftData

final class SwiftDataAsyncModelStreamFactory<ModelType: PersistentModel> {
    private(set) lazy var stream: AsyncThrowingStream<[ModelType], Error> = {
        AsyncThrowingStream { continuation in
            self.continuation = continuation
            self.setupNotification()
            self.fetch()
        }
    }()

    private let modelContext: ModelContext
    private let predicate: Predicate<ModelType>?
    private let sortDescriptors: [SortDescriptor<ModelType>]
    private var continuation: AsyncThrowingStream<[ModelType], Error>.Continuation?

    init(
        modelContext: ModelContext,
        predicate: Predicate<ModelType>? = nil,
        sortDescriptors: [SortDescriptor<ModelType>] = []
    ) {
        self.modelContext = modelContext
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
    }

    @objc private func fetch() {
        do {
            let fetchDesciptor = FetchDescriptor<ModelType>(predicate: predicate, sortBy: sortDescriptors)
            let models = try modelContext.fetch(fetchDesciptor)
            continuation?.yield(models)
        } catch {
            continuation?.finish(throwing: error)
        }
    }

    private func setupNotification() {
        // Ideally we'd use the ModelContext.didSave notification but this doesn't seem to be sent.
        // Last tested with iOS 17 beta 8 on September 4th, 2023.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetch),
            name: .NSPersistentStoreRemoteChange,
            object: nil
        )
    }
}
