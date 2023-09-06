public final class AnyAsyncSequence<AnyElement>: AsyncSequence {
    public typealias Element = AnyElement

    private let iteratorFactory: () -> AnyAsyncIterator<AnyElement>

    public init<AsyncSequenceType: AsyncSequence>(_ sequence: AsyncSequenceType) where AsyncSequenceType.Element == AnyElement {
        iteratorFactory = {
            AnyAsyncIterator(sequence)
        }
    }

    public func makeAsyncIterator() -> AnyAsyncIterator<AnyElement> {
        iteratorFactory()
    }
}
