import Foundation
import SwiftData

final class SwiftDataAsyncModelIterator<ModelType: PersistentModel>: AsyncIteratorProtocol {
    typealias Element = [ModelType]

    private let streamFactory: SwiftDataAsyncModelStreamFactory<ModelType>
    private var iterator: AsyncThrowingStream<[ModelType], Error>.Iterator?
    private var _stream: AsyncThrowingStream<[ModelType], Error>?
    private var stream: AsyncThrowingStream<[ModelType], Error> {
        if let _stream {
            return _stream
        } else {
            let stream = streamFactory.stream
            _stream = stream
            return stream
        }
    }

    init(
        modelContext: ModelContext,
        predicate: Predicate<ModelType>? = nil,
        sortDescriptors: [SortDescriptor<ModelType>] = []
    ) {
        streamFactory = SwiftDataAsyncModelStreamFactory(
            modelContext: modelContext,
            predicate: predicate,
            sortDescriptors: sortDescriptors
        )
    }

    func next() async throws -> Element? {
        if iterator == nil {
            iterator = stream.makeAsyncIterator()
        }
        return try await iterator?.next()
    }
}
