import Foundation
import Combine

extension Publisher where Output: Sequence {
    public func maxElement(by areInIncreasingOrder: @escaping (Self.Output.Element, Self.Output.Element) throws -> Bool) -> Publishers.TryMap<Self, Self.Output.Element?> {
        tryMap { sequence in try sequence.max(by: areInIncreasingOrder) }
    }
    
    public func maxElement<T>(by keyPath: KeyPath<Self.Output.Element, T>) -> Publishers.Map<Self, Self.Output.Element?> where T: Comparable {
        map { $0.max(by: keyPath) }
    }

    public func minElement(by areInIncreasingOrder: @escaping (Self.Output.Element, Self.Output.Element) throws -> Bool) -> Publishers.TryMap<Self, Self.Output.Element?> {
        tryMap { sequence in try sequence.min(by: areInIncreasingOrder) }
    }
    
    public func minElement<T>(by keyPath: KeyPath<Self.Output.Element, T>) -> Publishers.Map<Self, Self.Output.Element?> where T: Comparable {
        map { $0.min(by: keyPath) }
    }
    
    public func filterElements(_ isIncluded: @escaping (Self.Output.Element) throws -> Bool) -> Publishers.TryMap<Self, [Output.Element]> {
        tryMap { sequence in try sequence.filter(isIncluded) }
    }

    public func mapElements<T>(_ transform: @escaping (Self.Output.Element) -> T) -> Publishers.Map<Self, [T]> {
        map { sequence in sequence.map(transform) }
    }
    
    public func mapElements<T>(_ keyPath: KeyPath<Self.Output.Element, T>) -> Publishers.Map<Self, [T]> {
        map { sequence in sequence.map(keyPath) }
    }
}


extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
    
    func min<T>(by keyPath: KeyPath<Element, T>) -> Element? where T: Comparable {
        self.min { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    
    func max<T>(by keyPath: KeyPath<Element, T>) -> Element? where T: Comparable {
        self.max { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

