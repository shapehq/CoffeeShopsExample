public final class AnyAsyncIterator<AnyElement>: AsyncIteratorProtocol {
    public typealias Element = AnyElement

    private var _next: () async throws -> AnyElement?

    public init<AsyncSequenceType: AsyncSequence>(_ sequence: AsyncSequenceType) where AsyncSequenceType.Element == AnyElement {
        var it = sequence.makeAsyncIterator()
        _next = {
            try await it.next()
        }
    }

    public func next() async throws -> Element? {
        try await _next()
    }
}
